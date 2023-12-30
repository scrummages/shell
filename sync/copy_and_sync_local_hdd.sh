#!/bin/bash

function handle_ctrl_c() {
    echo "You pressed Ctrl+C!"
	sudo umount /mnt/hdd \
    && sudo cryptsetup luksClose hdd    
    exit 1
}

trap handle_ctrl_c SIGINT

target_uuid="4217e645-895a-4c89-8cc0-ca117d0f2f7f"

blkid_output=$(blkid)

if grep -q "$target_uuid" <<< "$blkid_output"; then
    device_name=$(grep "$target_uuid" <<< "$blkid_output" | cut -d: -f1)

    echo "Disk with UUID $target_uuid found at $device_name!"

else
    echo "Disk with UUID $target_uuid not found!"
    exit 1
fi

directories=("/mnt/hdd" "/tmp/sync")

for directory in "${directories[@]}"; do
    if [ -d "$directory" ]; then
        echo "Directory $directory already exists."
    else
        sudo mkdir -p "$directory"

        if [ $? -eq 0 ]; then
            echo "Directory $directory created successfully."
        else
            echo "Failed to create directory $directory."
            exit 1
        fi
    fi
done

cp ~/.bashrc ~/Media/Configs/.bashrc \
&& cp -avp ~/.config/micro/settings.json ~/Media/Configs/micro/settings.json \
&& cp -av ~/.config/i3/config ~/Media/Configs/i3/config \
&& cp -av ~/.config/i3status/config ~/Media/Configs/i3status/config \
&& cp -av ~/.config/alacritty/alacritty.toml ~/Media/Configs/alacritty/alacritty.toml \
&& cp -av ~/.config/ranger/rc.conf ~/Media/Configs/ranger/rc.conf \
&& cp -av ~/.config/picom.conf ~/Media/Configs/picom.conf \
&& sudo cryptsetup luksOpen $device_name hdd \
&& sudo mount /dev/mapper/hdd /mnt/hdd \
&& rsync -av --dry-run --delete --exclude WIKIs --exclude ISO ~/Media/ /mnt/hdd > /tmp/rsync; grep --color=auto -E "^deleting" /tmp/rsync; read -p "Do you wish to continue? (y/n) " user_response \
&& if [[ $user_response =~ ^[Yy]$ ]]; then
    rsync -av --delete --exclude WIKIs --exclude ISO ~/Media/ /mnt/hdd
fi \
&& sudo umount /mnt/hdd \
&& sudo cryptsetup luksClose hdd
