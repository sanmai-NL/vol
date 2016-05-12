#!/bin/sh -ex

## A minimal POSIX shell library to help manage Docker data volumes.
##
## For example, to copy the contents of '/root/keystore/' into a volume "$VOL_KEYSTORE":
## dir_out '/root/keystore/' | vol_in "$VOL_KEYSTORE"

dir_out() {
    ## Pipes out a tar -f target as pax stream.

    ## $1: A root directory to input.
    TARGET_IN="$1"
    ## $2: A tar -f target to output. Default: pipe.
    TARGET_OUT="${2:--}"

    tar -cvp --format='posix' --numeric-owner -f "$TARGET_OUT" -C "$TARGET_IN" '.'
}

vol_out() {
    ## Pipes out a tar stream from a volume.

    ## $1: A volume.
    VOL="$1"

    sudo docker run --attach='stderr' --attach='stdout' --rm --volume="$VOL"':/mnt/:ro' 'alpine' \
        tar -cpv -f '-' -C '/mnt/' '.'
}

vol_in() {
    ## Extracts tar stream into a volume.

    ## $1: volume
    VOL="$1"

    sudo docker run --attach='stdin' --interactive --rm --volume="$VOL"':/mnt/:rw' 'alpine' \
        tar -xpv -f '-' -C '/mnt/'
}

vol_clear() {
    ## Clears a volume, removing all its files and directories.

    ## $1: volume
    VOL="$1"

    sudo docker run --rm --volume="$VOL"':/mnt/:rw' 'alpine' \
        find '/mnt/' -mindepth '1' -exec rm -frv '{}' +
}

vol_ls() {
    ## Lists files and directories in the root of a volume.

    ## $1: volume
    VOL="$1"

    sudo docker run --rm --volume="$VOL"':/mnt/:ro' 'alpine' \
        ls -ahl '/mnt/'
}

## TODO: Safe rsync functionality.