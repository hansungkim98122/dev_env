#!/bin/bash

# Defaults
XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
HOST_WS_DIR=/media/govvijay/data/catkin_ws/
TARGET_WS_DIR=/home/govvijay/catkin_ws/
H_DATA_DIR=/media/govvijay/
T_DATA_DIR=/home/govvijay/media/
DOCKER_IMG="ros_env:latest"

docker run \
    --gpus all\
    -it --rm \
    --volume=$XSOCK:$XSOCK:rw \
    --volume=$XAUTH:$XAUTH:rw \
    --volume=$HOST_WS_DIR:$TARGET_WS_DIR:rw \
    --volume=$H_DATA_DIR:$T_DATA_DIR:rw \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    -u govvijay \
    --privileged -v /dev/bus/usb:/dev/bus/usb \
    $DOCKER_IMG

    #--net=host \
