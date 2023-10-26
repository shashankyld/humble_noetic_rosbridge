# humble_noetic_rosbridge_docker

Step 1: Launch the container
```
make up
make enter
```

Step 2: Run roscore in one container
```
source [ros1]
roscore
```

Step 3: Source ros2_ws/install/setup.bash
```
source ros2_ws/install/setup.bash
```

Step 4: Build the ros2 workspace with the ros1_bridge package
```
# Takes more than 5 minutes
colon build
```
```
# Takes more than 5 minutes
colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure
```

Step 5: Launch rosbridge 
```
# Bridge all topics both ways
ros2 run ros1_bridge dynamic_bridge
```

For help 
```
ros2 run ros1_bridge dynamic_bridge --help
```

