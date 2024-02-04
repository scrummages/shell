#!/bin/bash

test $# -eq 1 && device="$1"

lol=${device##*/}

{ sudo umount /dev/mapper/$lol && sudo cryptsetup luksClose $lol; } 2>/dev/null || sudo umount /mnt/$lol  && echo "[ec] unmounted"

sync
