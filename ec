#!/bin/sh

device="/dev/sda1"

test $# -eq 1 && device="$1"

lol=${device##*/}

sudo umount /dev/mapper/$lol &&\
sudo cryptsetup luksClose $lol

