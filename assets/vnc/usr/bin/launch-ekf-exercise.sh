#!/bin/bash
sed -i "s/vlx/${VEHICLE_NAME}/g" /opt/ros/noetic/share/rviz/ekf-localization.rviz
rviz -d /opt/ros/noetic/share/rviz/ekf-localization.rviz
