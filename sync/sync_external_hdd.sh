#!/bin/bash

target_uuid="b0fa1538-eb1c-47cc-99f2-439157b62728"

blkid_output=$(sudo blkid)

if grep -q "$target_uuid" <<< "$blkid_output"; then
    device_name=$(grep "$target_uuid" <<< "$blkid_output" | cut -d: -f1)

    echo "Disk with UUID $target_uuid found at $device_name!"

else
    echo "Disk with UUID $target_uuid not found!"
    exit 1
fi

sudo cryptsetup luksOpen $device_name hdd2 \
&& sudo mount /dev/mapper/hdd2 /mnt/hdd2 \
&& rsync -av --delete --exclude WIKIs --exclude ISO ~/Media/ /mnt/hdd2 \
&& sudo umount /mnt/hdd2 \
&& sudo cryptsetup luksClose hdd2 \
&& sync

