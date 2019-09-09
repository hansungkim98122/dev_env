#!/bin/bash

# Defaults
XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
HOST_WS_DIR=/media/govvijay/data/catkin_ws/
TARGET_WS_DIR=/home/govvijay/catkin_ws/
DOCKER_IMG="ros_env"

docker run \
    --gpus all\
    -it --rm \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume=$HOST_WS_DIR:$TARGET_WS_DIR:rw \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    -u govvijay \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    --net=host \
    $DOCKER_IMG
