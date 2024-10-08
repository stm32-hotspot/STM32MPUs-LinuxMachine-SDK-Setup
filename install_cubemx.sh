#!/bin/bash

export INSTALL_TOOLS=1
export INSTALL_TOOLS_CUBEMX=1
export INSTALL_VM_VERBOSE_ONLY='set -n'


echo "===================================================================================" 

echo "install STM32CubeMx"
echo "Modify INSTALL_VM_VERBOSE_ONLY to display only the commands without executing"

echo "===================================================================================" 

./install_VM_OpenSTLinux_v5_1.sh
