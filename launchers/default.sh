#!/bin/bash

source /environment.sh

source /opt/ros/noetic/setup.bash
source /code/devel/setup.bash --extend

exec roslaunch ekf_localization ekf_localization_node.launch veh:=$VEHICLE_NAME
