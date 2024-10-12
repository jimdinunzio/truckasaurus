#!/bin/bash

set -e

GREEN='\033[0;32m'
NC='\033[0m' # No Color

# first mkdir -p src/ if it does not exist
mkdir -p src/


# if src/nav2_gps_waypoint_follower_demo does not exist then do the following:
#   do a sparse checkout of https://github.com/ros-navigation/navigation2_tutorials.git (for branch use var $ROS_DISTRO)
#     of nav2_gps_waypoint_follower_demo directory to src/
if [ ! -d "src/navigation2_tutorials/nav2_gps_waypoint_follower_demo" ]; then
    echo
    echo -e "${GREEN}Cloning nav2_gps_waypoint_follower_demo...${NC}"
    echo
    git clone --depth 1 --filter=blob:none --sparse https://github.com/ros-navigation/navigation2_tutorials.git src/navigation2_tutorials
    cd src/navigation2_tutorials
    git sparse-checkout set nav2_gps_waypoint_follower_demo
    cd -
fi

# if src/nav2_mppi_controller does not exist then do the following:
#   do a sparse checkout of https://github.com/ros-navigation/navigation2.git (for branch use var $ROS_DISTRO) 
#     of nav2_mppi_controller directory to src/
if [ ! -d "src/navigation2/nav2_mppi_controller" ]; then
    echo
    echo -e "${GREEN}Cloning nav2_mppi_controller...${NC}"
    echo
    if [ ! -d "src/navigation2" ]; then
        git clone --depth 1 --filter=blob:none --sparse -b $ROS_DISTRO https://github.com/ros-planning/navigation2.git src/navigation2
    fi
    cd src/navigation2
    git sparse-checkout add nav2_mppi_controller
    cd -
fi

# check if arch is arm64
if [ "$(uname -m)" = "aarch64" ] && [ "$ROS_DISTRO" = "iron" ]; then
    # check if src/nav2_bringup does not exist
    if [ ! -d "src/navigation2/nav2_bringup" ]; then
        echo 
        echo -e "${GREEN}Cloning nav2_bringup and patching for gazebo build issue for IRON${NC}"
        echo
        cd src/navigation2
        git sparse-checkout add nav2_bringup
        # remove "turtlebot3_gazebo" dependency from nav2_bringup/package.xml since it has no arm64 build
        sed -i '/turtlebot3_gazebo/d' nav2_bringup/package.xml
        cd -
    fi
fi

# if src/micro_ros_msgs does not exist then do the following:
#   do a checkout of https://github.com/micro-ROS/micro_ros_msgs.git (for branch use var $ROS_DISTRO) to src/
if [ ! -d "src/micro_ros_msgs" ]; then
    echo
    echo -e "${GREEN}Cloning micro_ros_msgs...${NC}"
    echo
    git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_msgs.git src/micro_ros_msgs
fi

# if src/micro-ros-agent does not exist then do the following:
#   do a checkout of https://github.com/micro-ROS/micro-ROS-Agent.git (for branch use var $ROS_DISTRO) to current dir
#     then mv subdir micro-ros-agent to src/
#    and delete the checkout dir
if [ ! -d "src/micro-ROS-Agent" ]; then
    echo
    echo -e "${GREEN}Cloning micro-ROS-Agent...${NC}"
    echo
    git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro-ROS-Agent.git src/micro-ROS-Agent
fi

# if src/nmea_navsat_driver does not exist then do the following:
#   do a checkout of https://github.com/jimdinunzio/nmea_navsat_driver.git (for branch use ros2) to src/
if [ ! -d "src/nmea_navsat_driver" ]; then
    echo
    echo -e "${GREEN}Cloning nmea_navsat_driver...${NC}"
    echo
    git clone -b ros2 https://github.com/jimdinunzio/nmea_navsat_driver.git src/nmea_navsat_driver
fi

# if src/slamware_ros does not exist then do the following:
#  do a checkout of https://github.com/jimdinunzio/slamware_ros.git (for branch use ROS2) to src/
if [ ! -d "src/slamware_ros" ]; then
    echo
    echo -e "${GREEN}Cloning slamware_ros...${NC}"
    echo
    git clone -b ROS2 https://github.com/jimdinunzio/slamware_ros.git src/slamware_ros
fi

# if src/linorobot2 does not exist then do the following: 
#   do a checkout of https://github.com/jimdinunzio/linorobot2(for branch use var $ROS_DISTRO) to src/
if [ ! -d "src/trucksaurus" ]; then
    echo
    echo -e "${GREEN}Cloning linorobot2...${NC}"
    echo
    git clone -b $ROS_DISTRO https://github.com/jimdinunzio/linorobot2.git src/linorobot2
fi

# if src/mpu9250 does not exist then do the following:
#   do a checkout of https://github.com/jimdinunzio/mpu9250.git to src/
if [ ! -d "src/mpu9250" ]; then
    echo
    echo -e "${GREEN}Cloning mpu9250...${NC}"
    echo
    git clone https://github.com/jimdinunzio/mpu9250.git src/mpu9250
fi
