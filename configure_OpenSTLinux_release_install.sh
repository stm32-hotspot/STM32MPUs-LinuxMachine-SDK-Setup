#!/bin/bash


#===============================================
#===============================================

echo "------------------------------------------------------------" 	
echo "------------------------------------------------------------" 	
echo "configure install VM for release OpenSTLinux${OSTL_VERSION}" 
echo "configure this script for installation of the VM" 
echo "------------------------------------------------------------" 
echo "------------------------------------------------------------" 
echo "configure SHARED_DIR variable to your shared directory path"
echo "========SHARED_DIR====="
echo "------------------------------------------------------------" 
echo "------------------------------------------------------------" 
echo "configure package and tools versions for the release if not already done in the script"
echo "------------------------------------------------------------" 
echo "------------------------------------------------------------" 
echo "use stepx_xxx.sh script to install step by step the VM if not already installed"
echo "======stepx-xxx.sh=====" 
echo "These scripts use configured variables example INSTALL_PACKAGES_MP1"
echo "------------------------------------------------------------" 
echo "------------------------------------------------------------" 
echo "You can modify INSTALL_VM_VERBOSE_ONLY to display only the commands lines without executing"
echo "========INSTALL_VM_VERBOSE_ONLY==========="
echo "------------------------------------------------------------" 
echo "------------------------------------------------------------" 

#Get following packages in shared folder $SHARED_DIR
#
#-starter package
#
#-devpackage SDK
#
#-devpackage src
#
#-cubeprogrammer
#
#-cubemx
#
#-cubeide
#
#-install script of the VM for the release
#
#-gdb scripts
#


######################### Configurations for the release install
OSTL_VERSION=6.2.1
SHARED_DIR=/mnt/hgfs/shared/OpenSTLinux_v6.2.1_release/ST_packages_for_the_release
INSTALL_ROOT_DIR=/local
INSTALL_DIR=/local/OSTL-v${OSTL_VERSION}
INSTALL_TOOL_DIR_NAME=${HOME}/STM32MPU-Tools_Install
SDK_ROOT=${INSTALL_DIR}/Developer-Package
OSTL_FLASH_TAG=openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10
OSTL_TAG=openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10


###Dev package SDK
OSTL_TOOL_CHAIN=5.0.15
OSTL_TOOL_CHAIN_x86_64_SETUP=rootfs-x86_64-toolchain-5.0.17-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.sh
OSTL_TOOL_CHAIN_aarch64_SETUP=aarch64-toolchain-5.0.17-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.sh

OSTL_PACKAGES_MP1_STARTER_PACKAGE=FLASH-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.tar.gz
OSTL_PACKAGES_MP1_SDK_x86_64=SDK-x86_64-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.tar.gz
OSTL_PACKAGES_MP1_SDK_aarch64=SDK-aarch64-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.tar.gz
OSTL_PACKAGES_MP2_STARTER_PACKAGE=FLASH-stm32mp2-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.tar.gz
OSTL_PACKAGES_MP2_STARTER_PACKAGE_M33TD=FLASH-stm32mp2-m33td-openstlinux-6.6-yocto-scarthgap-mpu-v26.02.18.tar.gz
OSTL_PACKAGES_MP2_SDK_x86_64=SDK-x86_64-stm32mp2-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.tar.gz

###Dev package sources
OSTL_PACKAGES_MP_DEV_PACKAGE_SRC=SOURCES-stm32mp-openstlinux-6.6-yocto-scarthgap-mpu-v26.06.10.tar.gz

###Cube packages

CUBEMP15_PACKAGE_NAME=stm32cubemp1-v1-7-0.zip 
CUBEMP15_VERSION=1.7.0

CUBEMP13_PACKAGE_NAME=stm32cubemp13-v1-2-0.zip
CUBEMP13_VERSION=1.2.0

CUBEMP2_PACKAGE_NAME=STM32Cube_FW_MP2_V1.3.1.zip
CUBEMP2_VERSION=1.3.1

CUBEMP2_BM_PACKAGE_NAME=STM32CubeMP2-1.4.0.rc9.zip
CUBEMP2_BM_VERSION=1.4.0.rc9

CUBEMP2_TFM_DIRECTORY_NAME=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}/Middlewares/Third_Party/
CUBEMP2_TFM_VERSION=v2.1.3-stm32mp-r2

STM32DDRFW_UTIL_DIR_NAME=${HOME}

###Tools
CUBEPROG_VERSION=2.23.0
CUBEPROG_PACKAGE_NAME=SetupSTM32CubeProgrammer_linux_64.zip
CUBEPROG_PACKAGE_INSTALL_SCRIPT=SetupSTM32CubeProgrammer-2.23.0.linux


CUBEIDE_VERSION=2.2.0_29186_20260626_0934
CUBEIDE_PATH=/opt/st/stm32cubeide_2.2.2
CUBEIDE_PACKAGE_NAME=stm32cubeide_2.2.0-Lin-x86_64.sh.zip
CUBEIDE_PACKAGE_INSTALL_SCRIPT=stm32cubeide_2.2.0_29186_20260626_0934-Lin-x86_64.sh
CUBEIDE_Icon=${SHARED_DIR}/STM32CubeIDE.png

CUBEMX_VERSION=6.18.0
CUBEMX_PACKAGE_NAME=SetupSTM32CubeMX-6.18.0-Lin-x86_64.zip
CUBEMX_PACKAGE_INSTALL_SCRIPT=SetupSTM32CubeMX-6.18_0
CUBEMX_Icon=${SHARED_DIR}/STM32CubeMx.png


########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
#To be done once when creating the VM
INSTALL_VM=0 
#: ${INSTALL_VM_VERBOSE_ONLY:='set -n'} 
INSTALL_VM_VERBOSE_ONLY= 


######################### VM package install from developer package

####Install packages

INSTALL_PACKAGES_DIR=0 

INSTALL_PACKAGES_MP1=0 
INSTALL_PACKAGES_MP1_STARTER_PACKAGE=0
INSTALL_PACKAGES_MP1_SDK_x86_64=0 

INSTALL_PACKAGES_MP2=0 
INSTALL_PACKAGES_MP2_STARTER_PACKAGE=0 
INSTALL_PACKAGES_MP2_STARTER_PACKAGE_M33TD=0
INSTALL_PACKAGES_MP2_SDK_x86_64=0 

INSTALL_PACKAGES_MP_DEV_PACKAGE_SRC=0 

INSTALL_PACKAGE_MP2_FWDDR=0

INSTALL_DISTRIBUTION_PACKAGES_MP1=0 
INSTALL_DISTRIBUTION_PACKAGES_MP2=0 


######################### VM additionnal install and STM32 tool install
INSTALL_TOOLS=0 
INSTALL_TOOL_DIR=0 
INSTALL_TA_EXAMPLES=0 
BUILD_TA_EXAMPLES=0
INSTALL_GDB_SCRIPTS=0 
INSTALL_CUBEMP15=0 
INSTALL_CUBEMP13=0 
INSTALL_CUBEMP2=0
INSTALL_CUBEMP2_BM=0 
INSTALL_CUBEMP2_TFM=0 
INSTALL_STM32DDRFW_UTIL=0 
INSTALL_TOOLS_CUBEPROG=0 
INSTALL_TOOLS_CUBEMX=0 
INSTALL_TOOLS_CUBEIDE=0 
INSTALL_TOOLS_DESKTOP_ICONS=0 
#OUTPUT_FILE=/tmp/my_output.txt 
OUTPUT_FILE=/dev/stdout 



