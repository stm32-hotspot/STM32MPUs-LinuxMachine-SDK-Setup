#!/bin/bash

export INSTALL_TOOLS=1
export INSTALL_TOOLS_CUBEPROG=1
export INSTALL_VM_VERBOSE_ONLY='set -n'

echo "===================================================================================" 

echo "install STM32CubeProgrammer"
echo "Modify INSTALL_VM_VERBOSE_ONLY to display only the commands without executing"

echo "===================================================================================" 

./install_VM_OpenSTLinux_v5_1.sh
