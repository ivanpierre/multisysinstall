#!/bin/bash
#####
# Linux install for kilroySoft developpement in a multi flavoured environment
# Ivan Pierre 5/10/2019
# this file is called withe arguments, not utilized for now
# $1 linux flavour (default debian)
# $2 server name (default optiflex)

#####
# Set main variables
SERVER_CONF_PATH="optiplex"
FLAVOUR_CONF_PATH="debian"
export PATH=$PATH:`pwd`/$SERVER_CONF_PATH:`pwd`/$FLAVOUR_CONF_PATH

#####
# Source install file
. apt.install.bash

#####
# That's all folks
echo "fin de l'installation"
