#sudo docker run -it coldcard /bin/bash
xhost +local:docker

docker run \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $PWD/microSD:/build/firmware/unix/work/MicroSD \
-e DISPLAY=unix$DISPLAY -it \
coldcard

xhost -local:docker
