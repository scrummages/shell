#!/bin/bash

cp ~/.bashrc ~/Media/Code/Configs/home/.bashrc \
&& rsync -av --delete ~/.config/fish/ ~/Media/Code/Configs/config/fish/ \
&& rsync -av --delete --exclude buffers --exclude backups ~/.config/micro/ ~/Media/Code/Configs/config/micro/ \
&& cp -avp ~/.vimrc ~/Media/Code/Configs/home/.vimrc \
&& cp -avp ~/.Xresources ~/Media/Code/Configs/home/.Xresources \
&& cp -avp ~/.bash_functions ~/Media/Code/Configs/home/.bash_functions \
&& cp -avp ~/.config/i3/config ~/Media/Code/Configs/config/i3/config \
&& cp -avp ~/.config/i3status/config ~/Media/Code/Configs/config/i3status/config \
&& cp -avp ~/.config/alacritty/alacritty.toml ~/Media/Code/Configs/config/alacritty/alacritty.toml \
&& cp -avp ~/.config/ranger/rc.conf ~/Media/Code/Configs/config/ranger/rc.conf \
&& cp -avp ~/.config/picom.conf ~/Media/Code/Configs/config/picom.conf \
&& cp -avp /etc/pacman.conf ~/Media/Code/Configs/pacman.conf \
