FROM althack/ros2:iron-dev

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
   && apt-get -y install --no-install-recommends netcat \
   ament-lint \
   ros-$ROS_DISTRO-navigation2 ros-$ROS_DISTRO-example-interfaces \
   ros-$ROS_DISTRO-turtlesim \
   && apt-get autoremove -y \
   && apt-get clean -y \
   && rm -rf /var/lib/apt/lists/*

# Clean up
# && apt-get autoremove -y \
# && apt-get clean -y \
# && rm -rf /var/lib/apt/lists/*
# ENV DEBIAN_FRONTEND=dialog

# Set up auto-source of workspace for ros user
ARG USERNAME
ARG WORKSPACE

# Python setup
ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=1.4.0

RUN pip3 install "poetry==$POETRY_VERSION" colcon-poetry-ros

RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc
