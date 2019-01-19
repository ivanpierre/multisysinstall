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
sudo apt upgrade -y > /dev/null

####
# SSH
echo "Install open-ssh"
sudo apt install openssh-server -y > /dev/null

####
# Lauch SSH server
echo "Stasrt SSH"
sudo `which sshd` > /dev/null # start server

####
# Disk management
echo "Install parted"
sudo apt install gparted -y > /dev/null
sudo apt install parted -y > /dev/null

####
# config and mount disks
echo "Lauch and configure parted"
sudo umount -a
sudo cp $SERVER_CONF_PATH/etc/fstab /etc/
sudo mount -a

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
sudo apt install git -y

####
# Samba
echo "Installation done"
