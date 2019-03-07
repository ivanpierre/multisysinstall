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
        echo_ok "installing $*"
        echo_ok "$(tail -n 1 tmp.txt)"
    else
        echo_err "inst_apt: Installation error on $*"
        echo_err "$(tail -n 1 tmperr.txt)"
    fi

    echo 
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
# snap
inst_apt snapd

# lauch service
echo_start "Launch snapd service"
sudo service snapd start
echo_stop

####
# chromium
sudo snap install chromium > /dev/null

####
# VLC
# sudo snap remove vlc
sudo snap install vlc > /dev/null

####
# vscode
echo "Install vscode"
# sudo snap remove vscode
sudo snap install --classic vscode > /dev/null

####
# grub-customizer
sudo add-apt-repository ppa:danielrichter2007/grub-customizer > /dev/null
sudo apt update > /dev/null
inst_apt grub-customizer

####
# graphical environment (X11)
. x11.bash

####
# i3 (debian repository)
. i3.bash

####
# tasksel (debian repository)
. tasksel.bash

####
# multisystem
inst_apt gedit                  # To be able to edit config files
bash install-depot-multisystem.sh 

