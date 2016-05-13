#!/bin/sh -e

## Pipes out a directory as pax stream.

## $1: A root directory to input.
TARGET_IN="$1"
## $2: Extra parameters to pass on to tar.
PARAMS="$2"
## $3: A tar -f target to output. Default: pipe.
TARGET_OUT="${3:--}"

tar $PARAMS -cp --numeric-owner -f "$TARGET_OUT" -C "$TARGET_IN" '.'