#!/bin/bash

export INSTALL_PACKAGES_MP2=1
export INSTALL_PACKAGES_T_FA_GIT=0
export INSTALL_PACKAGES_T_FA_SRC=1
export CLEAN_PACKAGES_T_FA_SRC=0
export BUILD_PACKAGES_T_FA_SRC=1
export CLEAN_PACKAGES_T_FA_GIT=0
export BUILD_PACKAGES_T_FA_GIT=0
#export INSTALL_VM_VERBOSE_ONLY='set -n'
#export OUTPUT_FILE:=/tmp/my_output.txt
export OUTPUT_FILE=/dev/stdout

export BUILD_PACKAGES_T_FA_SDCARD=1
export BUILD_PACKAGES_T_FA_USB=0
export BUILD_PACKAGES_T_FA_UART=0


if [[(${BUILD_PACKAGES_T_FA_SDCARD} -eq 1)]];
then
export TF_A_CMD_LINE='FIP_CONFIG=optee-sdcard TF_A_CONFIG=optee-sdcard TF_A_DEVICETREE_optee-sdcard=stm32mp257f-ev1 TF_A_DEVICETREE=stm32mp257f-ev1 SPD=opteed STM32MP_DDR4_TYPE=1'

./install_VM_OpenSTLinux_v5_1.sh
fi

if [[(${BUILD_PACKAGES_T_FA_USB} -eq 1)]];
then

export TF_A_CMD_LINE='FIP_CONFIG=optee-sdcard TF_A_CONFIG=usb TF_A_DEVICETREE_optee-usb=stm32mp257f-ev1 TF_A_DEVICETREE=stm32mp257f-ev1'

./install_VM_OpenSTLinux_v5_1.sh
fi

if [[(${BUILD_PACKAGES_T_FA_UART} -eq 1)]];
then

export TF_A_CMD_LINE='FIP_CONFIG=optee-sdcard TF_A_CONFIG=uart TF_A_DEVICETREE_optee-uart=stm32mp257f-ev1 TF_A_DEVICETREE=stm32mp257f-ev1'

./install_VM_OpenSTLinux_v5_1.sh
fi
