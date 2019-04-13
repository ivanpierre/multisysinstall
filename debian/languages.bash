#!/bin/bash
#####
# Languages configuration for kilroySoft developpement
# Ivan Pierre 3/8/2019

#####
# Python version 2 & 3 (2 is deprecated)
inst_apt python-pip
inst_apt python3-pip
inst_apt python-setuptools
inst_apt python3-setuptools

pip2 install wheel
pip3 install wheel

#####
# Swift
inst_apt swift

#####
# Tensor flow
pip install -U --pre tensorflow
pip3 install -U --pre tensorflow

