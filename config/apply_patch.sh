## Apply this patch to build ROS1 

cp ros_comm.patch /ros_noetic_base_2204/catkin_ws/src/ros_comm
cp rosconsole.patch /ros_noetic_base_2204/catkin_ws/src/rosconsole
# Apply patch: git apply --ignore-whitespace <patch-file>
cd /ros_noetic_base_2204/catkin_ws/src/ros_comm
git apply --ignore-whitespace <ros_comm.patch
cd /ros_noetic_base_2204/catkin_ws/src/rosconsole
git apply --ignore-whitespace <rosconsole.patch
# Replace pluginlib package with one from /config
rm -rf /ros_noetic_base_2204/catkin_ws/src/pluginlib
cp -r /config/pluginlib /ros_noetic_base_2204/catkin_ws/src
# Some dependencies
sudo apt-get install libbz2-dev -y
sudo apt-get install libgpgme-dev -y 
sudo apt-get install liblog4cxx-dev -y

# Build ROS 1
cd /ros_noetic_base_2204/catkin_pkg && python3 setup.py install
cd /ros_noetic_base_2204/rospkg && python3 setup.py install
cd /ros_noetic_base_2204/catkin_ws
unset ROS_DISTRO
./src/catkin/bin/catkin_make install \
      -DCMAKE_BUILD_TYPE=Release \
      -DPYTHON_EXECUTABLE=/usr/bin/python3
source /ros_noetic_base_2204/catkin_ws/devel/setup.bash
