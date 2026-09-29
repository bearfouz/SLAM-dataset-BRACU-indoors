#!/bin/bash
# Starts the camera and publishes its data. Leave this running.

source /opt/ros/humble/setup.bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_LOCALHOST_ONLY=1

ros2 launch realsense2_camera rs_launch.py \
  rgb_camera.color_profile:=640x480x30 \
  depth_module.depth_profile:=640x480x30 \
  depth_module.infra_profile:=640x480x30 \
  enable_infra1:=true enable_infra2:=true \
  enable_gyro:=true enable_accel:=true unite_imu_method:=2 \
  align_depth.enable:=false \
  rgb_camera.enable_auto_exposure:=false \
  depth_module.enable_auto_exposure:=false \
  initial_reset:=true
