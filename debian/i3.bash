#! /bin/bash
# Install i3 package

####
# i3 (deprecated)
#inst_apt i3

####
# i3-gaps (replace i3)
# A big load of necessary package to compule gaps
echo remove i3
sudo apt purge i3 > /dev/null
sudo apt remove i3 > /dev/null

inst_apt xcb
inst_apt libxcb-shape0-dev
inst_apt libxcb-xinerama0-dev
inst_apt libxcb-randr0-dev
inst_apt libxcb-xkb-dev
inst_apt libxcb-xrm-dev

inst_apt libxcb1-dev 
inst_apt libxcb-keysyms1-dev 
inst_apt libpango1.0-dev 
inst_apt libxcb-util0-dev 
inst_apt libxcb-icccm4-dev 
inst_apt libyajl-dev 
inst_apt libstartup-notification0-dev 
inst_apt libxcb-randr0-dev 
inst_apt libev-dev 
inst_apt libxcb-cursor-dev 
inst_apt libxcb-xinerama0-dev 
inst_apt libxcb-xkb-dev 
inst_apt libxkbcommon-dev 
inst_apt libxkbcommon-x11-dev 
inst_apt xutils-dev 
inst_apt autoconf
inst_apt automake

# Install Airblader from source
echo install Airblader
sudo rm -rf tmp/
mkdir tmp 
cd tmp
git clone https://github.com/Airblader/xcb-util-xrm > /dev/null
cd xcb-util-xrm
git submodule update --init > /dev/null
./autogen.sh --prefix=/usr > /dev/null
make > /dev/null
sudo make install > /dev/null
cd ..

# Install i3-gaps from source
echo install i3-gaps
git clone https://www.github.com/Airblader/i3 i3-gaps > /dev/null
cd i3-gaps
autoreconf --force --install > /dev/null
mkdir build > /dev/null
cd build
../configure --prefix=/usr --sysconfdir=/etc > /dev/null
make > /dev/null
sudo make install > /dev/null
cd ..
cd ..
cd ..
sudo rm -rf tmp

# Dont forget to get configuration file in peronal config
# cp /etc/i3/config ~/.i3/config

####
# i3lock
inst_apt i3lock 

####
# suckless-tools
inst_apt suckless-tools 

####
# i3status (display status line)
inst_apt i3status 

####
# dmenu (i3 menu)
inst_apt dmenu

inst_apt apparmor-profiles-extra

####
# dwm (i3 menu)
inst_apt dwm

####
# surf (browser)
inst_apt surf

####
# ranger (file browser)
inst_apt ranger

####
# vifm (file browser)
inst_apt vifm

####
# neovim (editor)
inst_apt neovim

####
# vim-scripts (plug-ins for vim)
inst_apt vim-scripts

####
# ctags
inst_apt ctags 

####
# arandr (screen layout)
inst_apt arandr

####
# calcurse (calendar)
inst_apt calcurse

####
# xcompmgr (is for transparency and removing screen-tearing.)
# https://wiki.archlinux.org/index.php/xcompmgr
# https://help.ubuntu.com/community/TransparentTerminals
inst_apt xcompmgr

####
# transset-df
# a load of necessary packages
inst_apt libxcomposite1 
inst_apt libxcomposite-dev 
inst_apt libxfixes3 
inst_apt libxfixes-dev 
inst_apt libxdamage1 
inst_apt libxdamage-dev 
inst_apt libxrender1 
inst_apt libxrender-dev

# compile transset-df from source
echo compile transset-df from source
sudo rm -rf tmp/
mkdir tmp
cd tmp
wget http://forchheimer.se/transset-df/transset-df-4.tar.gz
tar zxf transset-df-4.tar.gz 
cd transset-df-4
make > /dev/null
sudo make install > /dev/null
cd ..
cd ..
sudo rm -rf tmp
inst_apt transset-df-4

####
# urxvt (transparent terminal)
inst_apt rxvt-unicode

####
# stterm (transparent terminal)
inst_apt stterm 

####
# dosfstools (allows your computer to access dos-like filesystems)
inst_apt dosfstools

####
# notify-osd and others (for notifications)
inst_apt notify-osd
inst_apt notification-daemon 
inst_apt libnotify-bin

####
# dunst (for notifications)
inst_apt libxdg-basedir-dev 
inst_apt libxss-dev
inst_apt dunst

inst_apt exfat-utils        # allows management of FAT drives.
inst_apt sxiv               # is a minimalist image viewer.
# inst_apt xwallpaper       # sets the wallpaper.
