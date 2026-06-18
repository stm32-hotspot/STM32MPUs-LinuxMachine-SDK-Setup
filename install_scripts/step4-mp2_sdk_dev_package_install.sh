#!/bin/bash



source ../configure_OpenSTLinux_release_install.sh

export INSTALL_PACKAGES_MP2=1 
export INSTALL_PACKAGES_MP2_SDK_x86_64=1 


source main_script_install_packages.sh
