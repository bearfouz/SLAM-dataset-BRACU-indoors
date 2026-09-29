#!/bin/bash
# Usage: ./record.sh room_seq01
# Records everything into ~/slam_dataset/bags/<name>

source /opt/ros/humble/setup.bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_LOCALHOST_ONLY=1
NAME=$1
if [ -z "$NAME" ]; then
  echo "Give the recording a name, e.g. ./record.sh room_seq01"
  exit 1
fi

BAGDIR=~/slam_dataset/bags     # change this later if you add an SSD
cd "$BAGDIR"

ros2 bag record -s mcap -o "$NAME" \
  --max-cache-size 2000000000 --max-bag-size 4000000000 \
  /camera/camera/color/image_raw /camera/camera/color/camera_info \
  /camera/camera/depth/image_rect_raw /camera/camera/depth/camera_info \
  /camera/camera/infra1/image_rect_raw /camera/camera/infra1/camera_info \
  /camera/camera/infra2/image_rect_raw /camera/camera/infra2/camera_info \
  /camera/camera/imu /camera/camera/gyro/sample /camera/camera/accel/sample \
  /camera/camera/extrinsics/depth_to_color \
  /tf_static
