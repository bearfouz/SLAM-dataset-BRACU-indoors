#!/bin/bash
# Prepares the computer for recording. Run once after every reboot.

source /opt/ros/humble/setup.bash          # makes the "ros2" command work
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

sudo sysctl -w net.core.rmem_max=2147483647
sudo sysctl -w net.ipv4.ipfrag_time=3
sudo sysctl -w net.ipv4.ipfrag_high_thresh=134217728
sudo cpupower frequency-set -g performance
