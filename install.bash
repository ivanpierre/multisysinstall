#!/bin/bash
#####
# Linux install for kilroySoft developpement in a multi flavoured environment
# Ivan Pierre 1/9/2019
# this file is called withe arguments, not utilized for now
# $1 linux flavour (default debian)
# $2 server name (default optiflex)

#####
# Set main variables
SERVER_CONF_PATH="optiplex"
FLAVOUR_CONF_PATH="debian"
export PATH=$PATH:$FLAVOUR_CONF_PATH

#####
# Source install file
. apt.install.bash

#####
# That's all for now
echo "fin de l'installation"
nohup
