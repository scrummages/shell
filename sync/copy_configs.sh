#!/bin/bash

cp -av /usr/share/rofi/themes/glue_pro_blue.rasi ~/Media/Code/Configs/glue_pro_blue.rasi
&& rsync -av --delete ~/.config/fish/ ~/Media/Code/Configs/config/fish/ \
&& rsync -av --delete --exclude buffers --exclude backups ~/.config/micro/ ~/Media/Code/Configs/config/micro/ \
&& cp -av  ~/.bashrc ~/Media/Code/Configs/home/.bashrc \
&& cp -av ~/.config/i3/config ~/Media/Code/Configs/config/i3/config \
&& cp -av ~/.config/i3status/config ~/Media/Code/Configs/config/i3status/config \
&& cp -av ~/.config/ranger/rc.conf ~/Media/Code/Configs/config/ranger/rc.conf \
&& cp -av ~/.Xresources ~/Media/Code/Configs/home/.Xresources \
&& cp -av ~/.vimrc ~/Media/Code/Configs/home/.vimrc \
