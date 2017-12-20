# Prometheus Monitoring Solution - Docker Container
With this project, you'll be able to build your own Prometheus docker container using the Docker Hub official CentOS 7 image, download the prometheus version you want and copying the configuration file you modify to start using Prometheus easily in your environments!

Using the makefile, you'll be able to re-build the image to load new changes & re-launch it with the default port.

# Installation & Use Guide

## Pre-requisites
You'll need the following installed in your host machine:
- [Docker](https://www.docker.com/get-docker) (CE, EE...)

If you want to use the makefile, you'll need:
- [Make](https://www.gnu.org/software/make/)

## How to

### Build & run manually
Simply make use of the common docker commands:

`docker build -t label/prometheus:2.0.0 .` (positioning yourself in the prometheus folder of this project)
`docker run -p 9090:9090 label/prometheus:2.0.0` 

### Build & run with makefile
Just place yourself where the makefile is and execute the following options:

`make build` - Builds the image
`make run` - Runs the image

And that's it, with this you'll have your own Prometheus docker container working, without any problems!
