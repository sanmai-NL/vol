#!/bin/sh -e

## Extracts tar stream into a volume.

## $1: A volume.
VOL="$1"
## $2: Extra parameters to pass on to tar.
PARAMS="$2"

docker run --interactive --rm --volume="${VOL}:/mnt/:rw" 'alpine' \
    tar $PARAMS -xp -f '-' -C '/mnt/'