# Cuda Dev Environment

## About

This project aims to deliver a ready-to-use development environment pre-configured with all necessary dependencies for seamless CUDA-based deep learning development.

## Dependencies

- [docker](https://www.docker.com/)
- [Nvidia Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit)
- [Nvidia Driver for the GPU](https://www.nvidia.com/en-us/drivers/)

## Pre Requisites

Ensure that the NVIDIA runtime is properly configured in Docker. To do this, verify that the /etc/docker/daemon.json file includes the following:

```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
```

## How to use

Clone this repository to your desired location:

    git clone https://github.com/dmnunez1993/cuda-dev-environment.git

Move to the repository folder:

    cd cuda-dev-environment

This development environment enables you to specify any working directory on the host system, independent of this project. The goal is to allow the reuse of the environment as needed. Therefore, it’s important to have a working directory in mind before proceeding.

To run the development environment:

    ./dev_env  --workdir /absolute/path/to/workdir

This command performs the following functions:

* Builds a Docker image containing all the necessary dependencies for CUDA.
* Skips the build step if the image has already been created previously.
* Creates a Docker container once the image is ready, with the specified working directory mounted as a volume.

A Python virtual environment is created by default. However, it is also posible to install other tools such as Conda, Pyenv, as needed.

If the project needs specific configurations (e.g., loading Pyenv or Conda), is it possible to create or modify a .bashrc file within the container's home folder to meet these requirements.

    cd ~
    touch .bashrc
    vim .bashrc

Once the changes are complete:

    source .bashrc

Afterward, you can navigate back to the working directory within the development environment. The directory is always mounted at the root of the repository, and its name matches the name of the working directory on the host system. For example, if your working directory on the host system is /absolute/path/to/workdir, you can return to it in the development environment by navigating to:

    cd /workdir
