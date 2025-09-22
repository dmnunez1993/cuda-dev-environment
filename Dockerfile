FROM nvidia/cuda:12.6.3-runtime-ubuntu22.04

ARG USER_UID
ARG USER_NAME

ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd -g ${USER_UID} ${USER_NAME}
RUN useradd -r -u ${USER_UID} -g ${USER_UID} ${USER_NAME}

# Install deps
RUN apt-get update && apt-get install -y sudo python3 python3-dev python3-pip curl git

# Install pyenv deps
RUN apt-get update && apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils \
    tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libopenmpi-dev

RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker

# Install misc
RUN apt-get update && apt-get install -y vim bash-completion
RUN pip3 install virtualenv

# Set up locales
RUN apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

# Set up terminal colors
ENV TERM=xterm-256color
COPY ./scripts/00-aliases.sh /etc/profile.d/
COPY ./scripts/02-colors.sh /etc/profile.d/

# Set up executables for creating the environment
COPY ./scripts/attach_env /usr/local/bin
COPY ./scripts/setup_env /usr/local/bin

# Set up user
USER ${USER_NAME}
ENV HOME=/home/${USER_NAME}
