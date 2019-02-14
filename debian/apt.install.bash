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

export BLACK=30
export RED=31
export GREEN=32
export YELLOW=33
export BLUE=34
export MAGENTA=35
export CYAN=36
export LIGHTGRAY=37
export LIGHT=60
export BACKGROUND=10
export BRIGHT=1
export DIM=2
export UNDERLINE=4
export BLINK=5
export REVERSE=7
export HIDDEN=8

echo_err() { # red background
    echo -e "\e[${REVERSE};${RED}m$1\e[0m"
}

echo_ok() { # green 
    echo -e "\e[${BRIGHT};${GREEN}m$1\e[0m"
}

echo_start() { # blue start red
    echo -e "\e[${BRIGHT};${GREEN}m$1\e[${BRIGHT};${RED}m"
}

echo_stop() { # back to normal
    echo -e "\e[0m"
}

inst_apt() {
	if [ $# -lt 1 ]; then
		echo_err "inst_apt: package expected" 
		return
	fi

    sudo apt install $* -y > tmp.txt 2> tmperr.txt 
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
echo_start "Start SSH"
sudo `which sshd` > /dev/null # start server
echo_stop

echo_start "add credencials for $USER"
ssh-add "/home/$USER/.ssh/id_ivan"
echo_stop

####
# Disk management
inst_apt gparted
inst_apt parted

####
# config and mount disks
# Unmount all external disks
echo "Unmount all disks"
sudo umount -av
echo

echo_start "create parted disk data"
# get disk of /
UUID=`df -P / | tail -1 | cut -d' ' -f 1`
# get UUID of disk
UUID=`blkid -s UUID -o value $UUID`
# create new fstab
sudo sed "s/{UUID}/$UUID/g" <$SERVER_CONF_PATH/etc/fstab >$SERVER_CONF_PATH/etc/fstab.new
# copy in root file system config
sudo cp $SERVER_CONF_PATH/etc/fstab.new /etc/fstab
echo_stop

# Remount all external disks
echo "Remount all disks" 
sudo mount -av
echo

####
# Samba
inst_apt samba
inst_apt smbclient

####
# Configure and launch Samba server
echo "Stop all samba services"
sudo service smbd stop
echo 

echo_start "copy configuration"
sudo cp -r $SERVER_CONF_PATH/etc/samba/* /etc/samba/
echo_stop

echo "Start all samba services"
sudo service smbd restart
echo 

####
# Ajoute l'accès a samba pour l'utilisateur
echo_start "Mot de passe du compte $USER pour samba"
sudo smbpasswd -a $USER
echo_stop

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

# lauch service
echo_start "Launch snapd service"
sudo service snapd start
echo_stop

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
echo "Install X11"
. x11.bash
echo

####
# i3 (debian repository)
echo "Install i3"
. i3-gaps.bash
echo

####
# grub-customizer
echo "Install grub-customizer"
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt-get update
inst_apt grub-customizer
echo

