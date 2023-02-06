# The U-Net segmentation server (caffe_unet) - in Docker

[![License](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)

This repository contains a Dockerfile and scripts to build and run the U-Net Segmentation server (caffe_unet) in Docker containers.

For users wish to integrate the U-Net Segmentation with python pipeline ([issue#23](https://github.com/lmb-freiburg/Unet-Segmentation/issues/23)), we also prepare a local runtime Docker image build without requirement of root permission. This facilitate the application of data processing in non-root environment like clusters.

Author: Thorsten Falk (falk@cs.uni-freiburg.de), Jacky Ka Long Ko (ka.ko@kennedy.ox.ac.uk)

If you use this project or parts of it in your research, please cite the corresponding paper:

```
@Article{FMBCAMBBR19,
  author       = "T. Falk and D. Mai and R. Bensch and {\"O}. {\c{C}}i{\c{c}}ek and A. Abdulkadir and Y. Marrakchi and A. B{\"o}hm and J. Deubner and Z. J{\"a}ckel and K. Seiwald and A. Dovzhenko and O. Tietz and C. Dal Bosco and S. Walsh and D. Saltukoglu and T. L. Tay and M. Prinz and K. Palme and M. Simons and I. Diester and T. Brox and O. Ronneberger",
  title        = "U-Net – Deep Learning for Cell Counting, Detection, and Morphometry",
  journal      = "Nature Methods",
  volume       = "16",
  pages        = "67--70",
  month        = "Jan",
  year         = "2019",
  url          = "http://lmb.informatik.uni-freiburg.de/Publications/2019/FMBCAMBBR19"
}
```

See the [paper](https://lmb.informatik.uni-freiburg.de/Publications/2019/FMBCAMBBR19/) and the [project page](https://lmb.informatik.uni-freiburg.de/resources/opensource/unet/) for more details.

## 0. Requirements

We use [nvidia-docker](https://github.com/NVIDIA/nvidia-docker#quick-start) for reliable GPU support in the containers. This is an extension to Docker and can be easily installed with just two commands. To run the networks, you need an nVidia GPU with >1GB of memory (at least Kepler).

## 1. Building the Docker image

Simply run `make`. This will create two Docker images: The OS base (an Ubuntu 18.04 base extended by nVidia, with CUDA 10.0 and CuDNN 7.3), and the "lmb-unet-server" image on top. In total, about **2.6GB** of space will be needed after building. This build will simply download the binary package from our project page, setup the environment to use it and when running the image start an SSH server that can be accessed via port 2222 of the docker host machine.

Alternatively you can run `make src` to build caffe_unet from source. The resulting image "lmb-unet-server-src" should work identical, but requires more space (about **6.7GB**). It is mainly intended to show you how caffe_unet can be built in a fresh Ubuntu installation.

For local runtime build (non-server), run `make local` to create image "lmb-unet-local". No sudoers privilege is need if you wish to deploy the segmentation binary in a rootless environment.

## 2. Running containers

Run the `startServer.sh` script. It will ask you to set the password for `unetuser`. Then the ssh server is started and you get an interactive shell in the container and the server awaits U-Net jobs on port 2222. Closing the session also terminates the server.

For local runtime run the `startLocal.sh` script. It will bring you to the interactive shell in the container without ssh service.

## 3. Singularity container
Singularity is a popular container software that used in rootless environments like clusters. To convert Docker image to Singularity one, follow the instruction:

### TLDR
```bash
bash ./startLocalSingularity.sh
```

1. Create local UNet Segmentation image with Docker
    ```bash
    make local
    ```
2. Build Singularity image
    ```bash
    singularity build lmb-unet-local.sif docker-daemon://lmb-unet-local:latest
    ```
3. Run the Singularity image and test if Caffe UNet runs smoothly. The package is located at `/home/unetuser/caffe_unet_package_18.04_gpu_cuda10_cudnn7/bin` within the container.
    ```bash
    singularity shell --nv lmb-unet-local.sif 
    cd /home/unetuser/caffe_unet_package_18.04_gpu_cuda10_cudnn7/bin
    ./caffe_unet
    ```

## 4. License
The files in this repository are under the [GNU General Public License v3.0](LICENSE)
