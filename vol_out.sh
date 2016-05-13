#!/bin/sh -e

## Pipes out a tar stream from a volume.

## $1: A volume.
VOL="$1"
## $2: Extra parameters to pass on to tar.
PARAMS="$2"

docker run --interactive --volume="${VOL}:/mnt/:ro" 'alpine' \
    tar $PARAMS -cp -f '-' -C '/mnt/' '.'