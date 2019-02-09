#!/bin/bash
#####
# Linux (Debian-like) configuration for kilroySoft developpement
# Ivan Pierre 1/9/2019
# this file is sourced from main install script

####
# main variables used
# SERVER_CONF_PATH="optiplex" # from install.bash

####
# Init apt cache and upgrade all
echo "Update packages"
sudo apt update -y > /dev/null
echo "Upgrade packages"
sudo apt upgrade -y > /dev/null

####
# SSH
echo "Install open-ssh"
sudo apt install openssh-server -y > /dev/null

####
# Lauch SSH server
echo "Stasrt SSH"
sudo `which sshd` > /dev/null # start server

echo "add credencials for $USER"
ssh-add "/home/$USER/.ssh/id_ivan"

####
# Disk management
echo "Install parted"
sudo apt install gparted -y > /dev/null
sudo apt install parted -y > /dev/null

####
# config and mount disks
echo "Lauch and configure parted"
# Unmount all external disks
sudo umount -a
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

####
# Samba
echo "Install Samba"
sudo apt install samba -y > /dev/null
sudo apt install smbclient -y > /dev/null

####
# Configure and launch Samba server
echo "Lauch and configure samba"
sudo service smbd stop
sudo cp $SERVER_CONF_PATH/etc/samba/smb.conf /etc/samba/
sudo cp -r $SERVER_CONF_PATH/var/lib/samba/usershares/* /var/lib/samba/usershares
sudo service smbd restart

####
# Ajoute l'accès a samba pour l'utilisateur
echo "Mot de passe du compte $USER pour samba"
sudo smbpasswd -a $USER

####
# applications

####
# git
echo "Install git"
sudo apt install git -y

####
# transmission
echo "Install transmission"
sudo apt install transmission

####
# multisystem
echo "Install multisystem"
sudo apt install multisystem

####
# snap
echo "Install snap"
sudo apt install snapd -y
sudo service snapd start

####
# chromium
echo "Install chromium"
snap install chromium

####
# VLC
echo "Install VLC"
snap install vlc

####
# vscode
echo "Install vscode"
snap install --classic vscode

