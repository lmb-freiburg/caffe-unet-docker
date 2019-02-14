#!/bin/bash

## Fail if any command fails (use "|| true" if a command is ok to fail)
set -e
## Treat unset variables as error
set -u

make
docker run --runtime=nvidia --rm --hostname "lmbunet" -p 2222:22 -it lmb-unet-server
