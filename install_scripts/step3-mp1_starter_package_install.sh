#!/bin/bash


source ../configure_OpenSTLinux_release_install.sh

export INSTALL_PACKAGES_MP1=1 
export INSTALL_PACKAGES_MP1_STARTER_PACKAGE=1 

source main_script_install_packages.sh
