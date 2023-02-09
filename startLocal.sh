#!/bin/bash

## Fail if any command fails (use "|| true" if a command is ok to fail)
set -e
## Treat unset variables as error
set -u

make
docker run --runtime=nvidia --rm -it lmb-unet-local