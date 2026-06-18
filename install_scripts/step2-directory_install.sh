#!/bin/bash


source ../configure_OpenSTLinux_release_install.sh

export INSTALL_PACKAGES_DIR=1
source install_packages.sh
export INSTALL_TOOLS=1
export INSTALL_TOOL_DIR=1
source main_script_install_packages.sh
