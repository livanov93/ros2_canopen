FROM ros:humble-ros-core

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        python3-rosdep \
        python3-argcomplete \
        python3-colcon-common-extensions \
        build-essential \
        pkg-config \
        python3-wheel \
        iproute2 \
        mesa-utils \
        nvidia-driver-515 \
	libxtst-dev \
	wget

WORKDIR /home
RUN wget https://download.jetbrains.com/cpp/CLion-2022.3.2.tar.gz && tar -xzf CLion*.tar.gz && rm CLion*.tar.gz

WORKDIR /home/can_ws/src
COPY . ros2_canopen

WORKDIR /home/can_ws/
RUN . /opt/ros/humble/setup.sh \
    && rosdep init && rosdep update \
    && rosdep install --from-paths src --ignore-src -r -y
#    && colcon build \
#    && . install/setup.sh

ENTRYPOINT ["tail", "-f", "/dev/null"]
