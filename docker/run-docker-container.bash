#!/bin/bash

DOCKER_IMAGE_NAME=asr-mic
DOCKER_CONTAINER_NAME=asr-mic

WORKSPACE_PATH=$HOME/workspace/asr-test-mic

# run docker
  docker run --rm \
    --device /dev/snd:/dev/snd \
    --net=host \
    --ipc=host \
    --gpus all \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $HOME/.Xauthority:$docker/.Xauthority \
    -v ${WORKSPACE_PATH}:$HOME/work \
    -v /media/liu/D:$HOME/datasets \
    -v /dev:/dev \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /run/dbus/:/run/dbus/:rw \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -it --name $DOCKER_CONTAINER_NAME $(id -un)/${DOCKER_IMAGE_NAME}

    # -it --name $DOCKER_CONTAINER_NAME ros:noetic-ros-core-focal
