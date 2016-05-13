#!/bin/sh -e

## Lists files and directories in the root of a volume.

## $1: A volume.
VOL="$1"
## $1: Extra parameters to pass on to ls.
PARAMS="$2"

docker run --rm --volume="$VOL"':/mnt/:ro' 'alpine' \
    ls $PARAMS -ahl '/mnt/'