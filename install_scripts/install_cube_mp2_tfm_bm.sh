#!/bin/bash


echo "===================================================================================" 

echo "install TFM in CubeFW_MP2"
echo "Modify INSTALL_VM_VERBOSE_ONLY to display only the commands without executing"

echo "===================================================================================" 



source ../configure_OpenSTLinux_release_install.sh
export CUBEMP2_TFM_DIRECTORY_NAME=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}/Middlewares/Third_Party/
export INSTALL_TOOLS=1
export INSTALL_CUBEMP2_TFM=1

#export INSTALL_VM_VERBOSE_ONLY='set -n'

source main_script_install_tools.sh

