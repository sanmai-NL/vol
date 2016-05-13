#!/bin/sh -ex

## A minimal POSIX shell library to help manage Docker data volumes.

dir_out() {
    ## Pipes out a directory as pax stream.

    ## $1: A root directory to input.
    TARGET_IN="$1"
    ## $2: Extra parameters to pass on to tar.
    PARAMS="$2"
    ## $3: A tar -f target to output. Default: pipe.
    TARGET_OUT="${3:--}"

    tar $PARAMS -cp --numeric-owner -f "$TARGET_OUT" -C "$TARGET_IN" '.'
}

vol_out() {
    ## Pipes out a tar stream from a volume.

    ## $1: A volume.
    VOL="$1"
    ## $2: Extra parameters to pass on to tar.
    PARAMS="$2"

    sudo -- docker run --interactive --volume="${VOL}:/mnt/:ro" 'alpine' \
        tar $PARAMS -cp -f '-' -C '/mnt/' '.'
}

vol_in() {
    ## Extracts tar stream into a volume.

    ## $1: A volume.
    VOL="$1"
    ## $2: Extra parameters to pass on to tar.
    PARAMS="$2"

    sudo -- docker run --interactive --rm --volume="${VOL}:/mnt/:rw" 'alpine' \
        tar $PARAMS -xp -f '-' -C '/mnt/'
}

vol_clear() {
    ## Clears a volume, removing all its files and directories.

    ## $1: A volume.
    VOL="$1"
    ## $2: Extra parameters to pass on to rm.
    PARAMS="$2"

    sudo -- docker run --rm --volume="${VOL}:/mnt/:rw" 'alpine' \
        rm $PARAMS -fr '/mnt/'
}

vol_ls() {
    ## Lists files and directories in the root of a volume.

    ## $1: A volume.
    VOL="$1"
    ## $1: Extra parameters to pass on to ls.
    PARAMS="$2"

    sudo -- docker run --rm --volume="$VOL"':/mnt/:ro' 'alpine' \
        ls $PARAMS -ahl '/mnt/'
}