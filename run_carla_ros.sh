#!/bin/bash

# Defaults
XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
HOST_WS_DIR=/media/govvijay/data/catkin_ws/
TARGET_WS_DIR=/home/govvijay/catkin_ws/
DATA_DIR=/home/govvijay/Dropbox/carla_data
DOCKER_IMG="carla-ros-bridge:latest"

docker run \
    --gpus all\
    -it --rm \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume=$HOST_WS_DIR:$TARGET_WS_DIR:rw \
    --volume=$DATA_DIR:$DATA_DIR:rw \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    -u govvijay \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    --net=host \
    $DOCKER_IMG
