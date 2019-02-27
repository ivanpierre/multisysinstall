#!/bin/bash
#####
# Core Linux (Debian-like) configuration for kilroySoft developpement
# Ivan Pierre 1/9/2019
# this file is sourced from main install script

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
# sudo umount -av
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
sudo mount -o remount -av
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


