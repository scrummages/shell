device_name="/dev/sdb1"

sudo cryptsetup luksOpen $device_name hdd2 \
&& sudo mount /dev/mapper/hdd2 /mnt/hdd2 \
&& rsync -av --delete ~/Media/ /mnt/hdd2 \
&& sudo umount /mnt/hdd2 \
&& sudo cryptsetup luksClose hdd2

