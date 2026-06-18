#!/bin/bash


source ../configure_OpenSTLinux_release_install.sh

export INSTALL_PACKAGES_MP2=1 
export INSTALL_PACKAGES_MP2_STARTER_PACKAGE_M33TD=1 

source main_script_install_packages.sh
