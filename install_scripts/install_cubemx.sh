#!/bin/bash




echo "===================================================================================" 

echo "install STM32CubeMx"
echo "Modify INSTALL_VM_VERBOSE_ONLY to display only the commands without executing"

echo "===================================================================================" 



source ../configure_OpenSTLinux_release_install.sh

export INSTALL_TOOLS=1
export INSTALL_TOOL_DIR=1
export INSTALL_TOOLS_CUBEMX=1
#export INSTALL_VM_VERBOSE_ONLY='set -n'


source main_script_install_tools.sh
