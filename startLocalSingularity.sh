#!/bin/bash

## Fail if any command fails (use "|| true" if a command is ok to fail)
set -e
## Treat unset variables as error
set -u

make local
singularity build --force lmb-unet-local.sif docker-daemon://lmb-unet-local:latest
singularity shell --nv lmb-unet-local.sif