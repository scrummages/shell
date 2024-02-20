#!/bin/bash

target_uuid="de2ddbb1-0b64-4bfa-a148-d4732b9eed0b"

blkid_output=$(sudo blkid)

if grep -q "$target_uuid" <<< "$blkid_output"; then
    device_name=$(grep "$target_uuid" <<< "$blkid_output" | cut -d: -f1)

    echo "Disk with UUID $target_uuid found at $device_name!"

else
    echo "Disk with UUID $target_uuid not found!"
    exit 1
fi

sudo cryptsetup luksOpen $device_name hdd3 \
&& sudo mount /dev/mapper/hdd3 /mnt/hdd3 \
&& rsync -av --delete --exclude WIKIs --exclude ISO ~/Media/ /mnt/hdd3 \
&& sudo umount /mnt/hdd3 \
&& sudo cryptsetup luksClose hdd3 \
&& sync

