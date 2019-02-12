#!/bin/bash
#####
# Linux (Debian-like) configuration for kilroySoft developpement
# Ivan Pierre 1/9/2019
# this file is sourced from main install script

####
# main variables used
# SERVER_CONF_PATH="optiplex" # from install.bash

#############################################################
# Functions
test_col () {
    for fgbg in 38 48 ; do # Foreground / Background
        for color in {0..255} ; do # Colors
            # Display the color
            printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
            # Display 6 colors per lines
            if [ $((($color) % 36)) == 15 ] ; then
                echo # New line
            fi
        done
    echo # New line
done
}

echo_err() {
    echo -e "\e[1;31m$1\e[0m"
}

echo_ok() {
    echo -e "\e[1;32m$1\e[0m"
}

inst_apt() {
	if [ $# -ne 1 ]; then
		echo_err "inst_apt: package expected" 
		return
	fi

    sudo apt install $1 -y > tmp.txt 2> tmperr.txt 
    local err=$?
    if [ $err -eq 0 ]; then
        echo_ok "installing $1"
        # echo_ok "$(tail -n 1 tmp.txt)"
    else
        echo_err "inst_apt: Installation error on $1"
        echo_err "$(tail -n 1 tmperr.txt)"
    fi

    return
}

#############################################################
# Entry point

####
# Init apt cache and upgrade all
echo "Update packages"
sudo apt update -y > /dev/null 2>&1
echo "Upgrade packages"
sudo apt upgrade -y > /dev/null 2>&1
echo 

####
# SSH
inst_apt openssh-server

####
# Lauch SSH server
echo "Start SSH"
sudo `which sshd` > /dev/null # start server
echo
echo "add credencials for $USER"
ssh-add "/home/$USER/.ssh/id_ivan"
echo 

####
# Disk management
inst_apt gparted
inst_apt parted

####
# config and mount disks
echo "Lauch and configure parted"
# Unmount all external disks
sudo umount -av
echo
# get disk of /
UUID=`df -P / | tail -1 | cut -d' ' -f 1`
# get UUID of disk
UUID=`blkid -s UUID -o value $UUID`
# create new fstab
sudo sed "s/{UUID}/$UUID/g" <$SERVER_CONF_PATH/etc/fstab >$SERVER_CONF_PATH/etc/fstab.new
# copy in root file system config
sudo cp $SERVER_CONF_PATH/etc/fstab.new /etc/fstab
# Remount all external disks 
sudo mount -av
echo

####
# Samba
inst_apt samba
inst_apt smbclient

####
# Configure and launch Samba server
echo "Lauch and configure samba"
sudo service smbd stop
sudo cp -r $SERVER_CONF_PATH/etc/samba/* /etc/samba/
sudo service smbd restart
echo 

####
# Ajoute l'accès a samba pour l'utilisateur
echo "Mot de passe du compte $USER pour samba"
sudo smbpasswd -a $USER
echo 

################################################
# utilitaires
inst_apt procps     # for pgrep
inst_apt ghex       # hex editor

################################################
# applications

####
# git
inst_apt git

####
# transmission
inst_apt transmission

####
# multisystem
inst_apt multisystem

####
# snap
inst_apt snapd

sudo service snapd start
echo 

####
# chromium
echo "Install chromium"
sudo snap install chromium
echo

####
# VLC
echo "Install VLC"
sudo snap install vlc
echo


####
# vscode
echo "Install vscode"
sudo snap install --classic vscode
echo


####
# graphical environment (X11)
inst_apt xorg
inst_apt xinit

inst_apt xserver-xorg
inst_apt xserver-xorg-video-intel

inst_apt fonts-noto-color-emoji
inst_apt fonts-noto-hinted
inst_apt fonts-noto-mono
inst_apt fonts-noto-unhinted
inst_apt fonts-freefont-ttf
inst_apt fonts-dejavu-core
inst_apt fonts-dejavu-extra
inst_apt yelp

####
# i3 (debian repository)
inst_apt i3
inst_apt i3lock 
inst_apt suckless-tools 
inst_apt i3status 
inst_apt dunst
# inst_apt i3-gaps
inst_apt rxvt-unicode
inst_apt dmenu
inst_apt apparmor-profiles-extra
inst_apt dwm 
inst_apt stterm 
inst_apt surf
