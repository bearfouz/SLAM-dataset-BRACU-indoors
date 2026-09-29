import sys, os
import numpy as np, cv2
from rosbag2_py import SequentialReader, StorageOptions, ConverterOptions
from rclpy.serialization import deserialize_message
from rosidl_runtime_py.utilities import get_message

bag, out = sys.argv[1], sys.argv[2]
EVERY = 300   # save 1 frame out of every 300 (about every 10 s)
os.makedirs(out, exist_ok=True)

r = SequentialReader()
r.open(StorageOptions(uri=bag, storage_id='mcap'), ConverterOptions('', ''))
types = {t.name: t.type for t in r.get_all_topics_and_types()}
want = {
    '/camera/camera/color/image_raw': 'color',
    '/camera/camera/depth/image_rect_raw': 'depth',
    '/camera/camera/infra1/image_rect_raw': 'ir1',
}
count = {k: 0 for k in want}

while r.has_next():
    topic, data, t = r.read_next()
    if topic not in want:
        continue
    count[topic] += 1
    if (count[topic] - 1) % EVERY != 0:
        continue
    msg = deserialize_message(data, get_message(types[topic]))
    h, w = msg.height, msg.width
    name = f"{out}/{want[topic]}_{count[topic]:05d}.png"
    if msg.encoding == 'rgb8':
        img = cv2.cvtColor(np.frombuffer(msg.data, np.uint8).reshape(h, w, 3), cv2.COLOR_RGB2BGR)
    elif msg.encoding == '16UC1':
        d = np.frombuffer(msg.data, np.uint16).reshape(h, w)
        print(f"{name}: {100 * np.mean(d == 0):.1f}% of depth pixels empty")
        img = cv2.applyColorMap(cv2.convertScaleAbs(d, alpha=255 / 4000), cv2.COLORMAP_JET)
    else:  # mono8 infrared
        img = np.frombuffer(msg.data, np.uint8).reshape(h, w)
    cv2.imwrite(name, img)
print("Done. Look in", out)
