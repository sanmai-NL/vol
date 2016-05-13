#!/bin/sh -e

## Clears a volume, removing all its files and directories.

## $1: A volume.
VOL="$1"
## $2: Extra parameters to pass on to rm.
PARAMS="$2"

docker run --rm --volume="${VOL}:/mnt/:rw" 'alpine' \
    rm $PARAMS -fr '/mnt/'