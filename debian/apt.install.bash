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
# Install principal files and configuration
. core.install.bash

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
inst_apt gedit                  # To be able to edit config files
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
# sudo snap remove chromium
sudo snap install chromium
echo

####
# VLC
echo "Install VLC"
# sudo snap remove vlc
sudo snap install vlc
echo

####
# vscode
echo "Install vscode"
# sudo snap remove vscode
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
. i3.bash
echo

####
# grub-customizer
echo "Install grub-customizer"
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt update
inst_apt grub-customizer
echo

####
# tasksel (debian repository)
echo We are currently at `pwd`
echo Path is $PATH
echo

echo "Install tasksel packages"
. tasksel.bash
echo

