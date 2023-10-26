# Starting Here - Focal - Ubuntu20, Jammy - Ubuntu22. ROS HUMBLE OFFICIAL DOCKER SUPPORTED ON JAMMY ONLY
FROM ros:humble-ros-base-jammy
RUN apt-get update

# Utilitaires
RUN apt-get install -y \
    git \
    cmake \
    wget \
    tar \
    libx11-dev \
    xorg-dev \
    libssl-dev \
    build-essential \
    libusb-1.0-0-dev \
    libglu1-mesa-dev \
    net-tools \
    iputils-ping 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  \
    libpcl-dev  \
    libpcap-dev -y \
    libboost-dev -y \
    libyaml-cpp-dev \
    python3-pip -y \
    python3-rosdep -y \
    vim -y 


RUN apt-get install -y \
        libboost-thread-dev \
        libboost-system-dev \
        libboost-filesystem-dev \
        libboost-regex-dev \
        libboost-program-options-dev \
        libconsole-bridge-dev \
        libpoco-dev \
        libtinyxml2-dev \
        liblz4-dev \
        libbz2-dev \
        uuid-dev \
        liblog4cxx-dev \
        libgpgme-dev \
        libgtest-dev

RUN apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-empy \
        python3-nose \
        python3-pycryptodome \
        python3-defusedxml \
        python3-mock \
        python3-netifaces \
        python3-gnupg \
        python3-numpy \
        python3-psutil \
        libpoco-dev \
        libbz2-dev \
        libgpgme-dev \
        liblog4cxx-dev 


RUN apt install libeigen3-dev -y \
    ros-humble-turtlesim


### INSTALLING ROS1 - NOETIC FROM SOURCE
## https://medium.com/@lukas_reisinger/building-ros-noetic-on-ubuntu-22-04-b3ca676c63e7


RUN mkdir -p ros_noetic_base_2204/catkin_ws/src && \
    cd ros_noetic_base_2204/catkin_ws/src && \
    git clone https://github.com/ros/actionlib.git -b 1.14.0 && \
    git clone https://github.com/ros/bond_core.git -b 1.8.6 && \
    git clone https://github.com/ros/catkin.git -b 0.8.10 && \
    git clone https://github.com/ros/class_loader.git -b 0.5.0 && \ 
    git clone https://github.com/ros/cmake_modules.git -b 0.5.0 && \ 
    git clone https://github.com/ros/common_msgs.git -b 1.13.1 && \
    git clone https://github.com/ros/dynamic_reconfigure.git -b 1.7.3 && \
    git clone https://github.com/ros/gencpp.git -b 0.7.0 && \
    git clone https://github.com/jsk-ros-pkg/geneus.git -b 3.0.0 && \
    git clone https://github.com/ros/genlisp.git -b 0.4.18 && \
    git clone https://github.com/ros/genmsg.git -b 0.6.0 && \
    git clone https://github.com/RethinkRobotics-opensource/gennodejs.git -b 2.0.1 && \
    git clone https://github.com/ros/genpy.git -b 0.6.16 && \
    git clone https://github.com/ros/message_generation.git -b 0.4.1 && \
    git clone https://github.com/ros/message_runtime.git -b 0.4.13 && \
    git clone https://github.com/ros/nodelet_core.git -b 1.10.2 && \
    git clone https://github.com/ros/pluginlib.git -b 1.13.0 && \
    git clone https://github.com/ros/ros.git -b 1.15.8  && \
    git clone https://github.com/ros/ros_comm.git -b 1.16.0  && \
    git clone https://github.com/ros/ros_comm_msgs.git -b 1.11.3 && \
    git clone https://github.com/ros/ros_environment.git -b 1.3.2 && \
    git clone https://github.com/ros/rosbag_migration_rule.git -b 1.0.1 && \
    git clone https://github.com/ros/rosconsole.git -b 1.14.3 && \
    git clone https://github.com/ros/rosconsole_bridge.git -b 0.5.4 && \
    git clone https://github.com/ros/roscpp_core.git -b 0.7.2 && \
    git clone https://github.com/ros/roslisp.git -b 1.9.25 && \
    git clone https://github.com/ros/rospack.git -b 2.6.2 && \
    git clone https://github.com/ros/std_msgs.git -b 0.5.13

RUN cd ros_noetic_base_2204 && \
    git clone https://github.com/ros-infrastructure/catkin_pkg.git -b 0.5.2 && \
    git clone https://github.com/ros-infrastructure/rospkg.git -b 1.5.0



# Install libpoco-dev
RUN apt install libpoco-dev -y && \
    # Install libbz2-dev
    apt install libbz2-dev -y && \
    # Install libgpgme-dev
    apt install libgpgme-dev -y && \
    # Install liblog4cxx-dev
    apt install liblog4cxx-dev -y

RUN pip install defusedxml 

COPY config /config


RUN cd /config && \
    bash apply_patch.sh && \
    bash export_ros_path.sh && \
    /bin/bash -c "source /ros_noetic_base_2204/catkin_ws/devel/setup.bash "

ENV ROS1_INSTALL_PATH=/ros_noetic_base_2204/catkin_ws/devel
ENV ROS2_INSTALL_PATH=/opt/ros/humble
# ENV MAKEFLAGS=-j1
RUN mkdir -p ros2_ws/src && \
    cd ros2_ws/src && \
    git clone https://github.com/ros2/ros1_bridge.git && \
    colcon build --symlink-install --packages-skip ros1_bridge 
    
RUN /bin/bash -c "source ${ROS2_INSTALL_PATH}/setup.bash && cd ros2_ws && colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure"

# RUN rosdep install --from-paths ros2_ws/src --ignore-src -r -y
    

# # Copy the custom entrypoint script to the container
# COPY config/entrypoint.sh /entrypoint.sh

# # Make the entrypoint script executable
# RUN chmod +x /entrypoint.sh

# # Set the entrypoint
# ENTRYPOINT ["/entrypoint.sh"]

