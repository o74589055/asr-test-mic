# syntax = docker/dockerfile:experimental
FROM tensorflow/tensorflow:2.3.2-gpu

# Arguments
ARG USER=initial
ARG GROUP=initial
ARG UID=1000
ARG GID=${UID}
ARG SHELL=/bin/bash
# Setup users and groups
RUN groupadd --gid ${GID} ${GROUP} \
  && useradd --gid ${GID} --uid ${UID} -ms ${SHELL} ${USER} \
  && mkdir -p /etc/sudoers.d \
  && echo "${USER}:x:${UID}:${UID}:${USER},,,:$HOME:${shell}" >> /etc/passwd \
  && echo "${USER}:x:${UID}:" >> /etc/group \
  && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}" \
  && chmod 0440 "/etc/sudoers.d/${USER}"

# Replace apt urls
#  RUN sed -i 's@archive.ubuntu.com@ftp.tku.edu.tw/@g' /etc/apt/sources.list
# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      sudo net-tools htop wget zip unzip \
      git rsync \
      apt-utils gcc libpq-dev libsndfile-dev git build-essential cmake screen \
      # edit tool
      nano vim \
      # shell
      byobu zsh terminator \
      gnome-terminal libcanberra-gtk-module libcanberra-gtk3-module \
      portaudio19-dev \
      python-all-dev \
      python3-setuptools \
      python3-all-dev \
      # work-tools
      python3-pip \
      # ros-noetic-rosserial-arduino ros-noetic-rosserial \
      # python3-pip python3-catkin-tools python3-setuptools \
      # python3-dev python3-gpiozero \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /home/${USER}/.tmp


# setup custom configuration
COPY config .

# shell
RUN bash ./script/bash_setup.bash \
  && bash ./script/terminator_setup.bash \
  && bash ./script/zsh_setup.bash \
  && bash ./script/byobu_setup.bash \
  # Dependent
  && bash ./script/rule_setup.bash \
  && bash ./script/pip_setup.bash \
  # && bash ./script/pigpio_setup.bash \
  && rm -rf /home/${USER}/.tmp

# Install rnnt_loss
# ARG install_rnnt_loss=true
# ARG using_gpu=true
# RUN if [ "$install_rnnt_loss" = "true" ] ; \
#     then if [ "$using_gpu" = "true" ] ; then export CUDA_HOME=/usr/local/cuda ; else echo 'Using CPU' ; fi \
#     && bash ./script/install_rnnt_loss.sh \
#     else echo 'Using pure TensorFlow'; fi

RUN echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> /root/.bashrc


# copy entrypoint
COPY entrypoint.bash /entrypoint.bash
RUN chmod 777 /entrypoint.bash

WORKDIR /home/${USER}

# Switch user to ${USER}
USER ${USER}

RUN sudo mkdir work

# Make SSH available
EXPOSE 22

# Switch to user's HOME folder
WORKDIR /home/${USER}/work

ENTRYPOINT ["/entrypoint.bash","byobu"]
# ENTRYPOINT ["byobu"]
