#!/bin/bash
source /ros2_ws/install/setup.bash  # Source your ROS 2 setup files
colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure
exec "$@"  # Pass any additional command line arguments
