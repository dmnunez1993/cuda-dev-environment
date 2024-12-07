FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04

ARG USER_UID
ARG USER_NAME

RUN userdel -r ubuntu
RUN groupadd -g ${USER_UID} ${USER_NAME}
RUN useradd -r -u ${USER_UID} -g ${USER_UID} ${USER_NAME}

# Install deps
RUN apt-get update && apt-get install -y sudo python3 python3-dev python3-pip curl git

RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker


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
