#!/bin/sh

xhost +local:root;

if (nvidia-smi|grep NVIDIA)
then
    # nvidia
    echo "NVIDIA GPU detected, initialization calibration container"
    docker run -it --privileged=true --net=host --gpus all \
      --env="NVIDIA_DRIVER_CAPABILITIES=all" \
      --env="DISPLAY" \
      --env="QT_X11_NO_MITSHM=1" \
      --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
      --volume="${PWD}:/workspace/zoe-depth" \
      --volume="/home/wangyike/Data:/data" \
      --volume="/mnt/nas/perception/yike:/nas" \
      -e HTTP_PROXY=http://127.0.0.1:7890 \
      -e HTTPS_PROXY=http://127.0.0.1:7890 \
      --name="zoe-depth" \
       zoe-depth:v0.1 /bin/bash  -c "cd /share;  /bin/bash;"
else

    echo "NVIDIA GPU NOT detected, please check system settings!"
fi
