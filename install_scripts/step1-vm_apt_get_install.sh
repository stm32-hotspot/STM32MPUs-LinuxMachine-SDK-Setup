#!/bin/bash

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
######################### VM package install from developer package

source ../configure_OpenSTLinux_release_install.sh

echo "install VM for release OpenSTLinux${OSTL_VERSION}" 
sudo apt-get update
sudo apt-get install gawk wget git git-lfs diffstat unzip texinfo gcc-multilib  chrpath socat cpio python3 python3-pip python3-pexpect
sudo apt-get install  xz-utils debianutils iputils-ping python3-git python3-jinja2 libsdl1.2-dev pylint xterm bsdmainutils libusb-1.0-0
sudo apt-get install libssl-dev libgmp-dev libmpc-dev lz4 zstd
sudo apt install libegl1-mesa

#for Developper package
sudo apt-get install build-essential libncurses-dev libyaml-dev libssl-dev

#for Distrubtion package
sudo apt install python-is-python3
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

#for tools
sudo apt-get install coreutils bsdmainutils sed curl bc lrzsz corkscrew cvs subversion mercurial nfs-common nfs-kernel-server libarchive-zip-perl dos2unix texi2html libxml2-utils
#additional install (not in wiki article)
sudo apt-get install minicom net-tools git-lfs

sudo apt install python3-pip

python3 -m pip install Jinja2
python3 -m pip install cbor2
python3 -m pip install intelhex
python3 -m pip install pyelftools
python3 -m pip install crypto
python3 -m pip install pycryptodomex

sudo locale-gen 'en_US.UTF-8'
sudo update-locale 
sudo adduser $USER disk
sudo adduser $USER tty
sudo adduser $USER dialout

#===========================================================

