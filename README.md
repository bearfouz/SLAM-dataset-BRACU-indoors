# D435i Indoor SLAM Dataset

Handheld recordings in a closed room with an Intel RealSense D435i.

## Hardware and software
- Camera: Intel RealSense D435i (firmware: <version>)
- Laptop: ASUS P453UA, Ubuntu 22.04, ROS 2 Humble
- realsense2_camera: <version>, librealsense: <version>
- Storage format: rosbag2, mcap

## Streams (640x480 @ 30 fps)
Color, depth, infra1, infra2, IMU (gyro ~200 Hz, accel ~100 Hz)

Topics have a doubled prefix, e.g. `/camera/camera/color/image_raw`.

## Sequences
| Name | Duration | Size | Notes |
|---|---|---|---|
| room_seq01_good | 368 s | 22.1 GiB | see sequences/room_seq01_notes.txt |
| room_seq02 | 280 s | 16.8 GiB | see sequences/room_seq02_notes.txt |

## Download
<links added after upload>

## Recording
See `scripts/`: setup_record.sh, start_camera.sh, record.sh.

## Known limitations
- No ground truth.
- About 1% of depth/IR frames are missing in each sequence.
- Factory calibration only (no Kalibr calibration yet).
