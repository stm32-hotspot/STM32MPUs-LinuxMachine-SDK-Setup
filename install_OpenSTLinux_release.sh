#!/bin/bash


#===============================================
ext#===============================================

echo "------------------------------------------------------------" 	
echo "------------------------------------------------------------" 	
echo "install VM for release OpenSTLinux${OSTL_VERSION}" 
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
echo "can build each component example tf-axx-build.sh"
echo "======tf-a-xx-build.sh=====" 
echo "with configured CLEAN_PACKAGES_T_FA_SRC/BUILD_PACKAGES_T_FA_SRC variables and build command line XXX_CMD_LINE"
echo "------------------------------------------------------------" 
echo "------------------------------------------------------------" 
echo "can use fip-xxx-build.sh (configured variables example BUILD_PACKAGES_FIP_MP1/CLEAN_PACKAGES_FIP_MP1)"
echo "======fip-xxx-build.sh=====" 
echo "This script build all bsp components for fip image : tf-a, optee, u-boot and fip image"
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
OSTL_VERSION=6.0
SHARED_DIR=/mnt/c/MPU/shared/release/OpenSTLinux_v6_release/
INSTALL_ROOT_DIR=/local
INSTALL_DIR=/local/STM32MPU-Ecosystem-v${OSTL_VERSION}
SDK_ROOT=${INSTALL_DIR}/Developer-Package
OSTL_FLASH_TAG=openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06
OSTL_TAG=openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06


###Dev package SDK
OSTL_TOOL_CHAIN=5.0.3
OSTL_TOOL_CHAIN_x86_64_SETUP=rootfs-x86_64-toolchain-5.0.3-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.sh
OSTL_TOOL_CHAIN_aarch64_SETUP=aarch64-toolchain-5.0.3-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.sh
OSTL_PACKAGES_MP1_STARTER_PACKAGE=FLASH-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz
OSTL_PACKAGES_MP1_SDK_x86_64=SDK-x86_64-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz
OSTL_PACKAGES_MP1_SDK_aarch64=en.SDK-aarch64-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz
OSTL_PACKAGES_MP2_STARTER_PACKAGE=FLASH-stm32mp2-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz
OSTL_PACKAGES_MP2_SDK_x86_64=SDK-x86_64-stm32mp2-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz
OSTL_PACKAGES_MP2_SDK_aarch64=en.SDK-aarch64-stm32mp2-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz

###Dev package sources
OSTL_PACKAGES_MP1_DEV_PACKAGE_SRC=SOURCES-stm32mp1-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz
OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC=SOURCES-stm32mp2-openstlinux-6.6-yocto-scarthgap-mpu-v24.11.06.tar.gz

###Dev package bsp components

TF_A_VERSION=v2.10.5-stm32mp-r1-r0
TF_A_DIR=v2.10.5-stm32mp-r1
TF_A_GIT=v2.10-stm32mp-r1

U_BOOT_VERSION=v2023.10-stm32mp-r1-r0
U_BOOT_DIR=v2023.10-stm32mp-r1
U_BOOT_GIT=v2023.10-stm32mp-r1

OPTEE_VERSION=4.0.0-stm32mp-r1-r0
OPTEE_DIR=4.0.0-stm32mp-r1
OPTEE_GIT=4.0.0-stm32mp-r1

EXTDT_DIRECTORY_NAME=external-dt-6.0-r0/external-dt-6.0


FWDDR_VERSION=A2022.11-r0
FWDDR_DIR_NAME=A2022.11

LINUX_VERSION=6.6.48-stm32mp-r1-r0
LINUX_DIR=6.6.48
LINUX_GIT=v6.6-stm32mp-r1

GCNANO_VERSION=6.4.19-stm32mp2-r1-rc8-r0
GCNANO_DIR=6.4.19-stm32mp2-r1-rc8
GCNANO_GIT=bbaae49a0e4859ed53f898a250269c8a237261bc





###Cube packages

CUBEMP1_PACKAGE_NAME=en.STM32Cube_FW_MP1_V1.6.0.zip 
CUBEMP1_VERSION=1.6.0

CUBEMP13_PACKAGE_NAME=en.stm32cubemp13-v1-1-0.zip 
CUBEMP13_VERSION=1.1.0


###Tools
CUBEPROG_VERSION=2.17.0
CUBEPROG_PACKAGE_NAME=en.stm32cubeprg-lin-v2-17-0.zip
CUBEPROG_PACKAGE_INSTALL_SCRIPT=SetupSTM32CubeProgrammer-2.17.0.linux

CUBEIDE_VERSION=1.16.0_21983_20240628_1741
CUBEIDE_PATH=/opt/st/stm32cubeide_1.16.0
CUBEIDE_PACKAGE_NAME=en.st-stm32cubeide_1.16.0_21983_20240628_1741_amd64.sh.zip
CUBEIDE_PACKAGE_INSTALL_SCRIPT=st-stm32cubeide_1.16.0_21983_20240628_1741_amd64.sh
CUBEIDE_Icon=/home/osboxes/Downloads/STM32CubeIDE.png

CUBEMX_VERSION=6.12.0
CUBEMX_PACKAGE_NAME=en.stm32cubemx-lin-v6-12-0.zip
CUBEMX_PACKAGE_INSTALL_SCRIPT=SetupSTM32CubeMX-6.12.0
CUBEMX_Icon=/home/osboxes/Downloads/STM32CubeMx.png

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
#To be done once when creating the VM
: ${INSTALL_VM:=0} 
#: ${INSTALL_VM_VERBOSE_ONLY:='set -n'} 
: ${INSTALL_VM_VERBOSE_ONLY:=} 


######################### VM package install from developer package

####Install packages

: ${INSTALL_PACKAGES_DIR:=0} 

: ${INSTALL_PACKAGES_MP1:=0} 
: ${INSTALL_PACKAGES_MP1_STARTER_PACKAGE:=0} 
: ${INSTALL_PACKAGES_MP1_SDK_x86_64:=0} 
: ${INSTALL_PACKAGES_MP1_SDK_aarch64:=0} 

: ${INSTALL_PACKAGES_MP2:=0} 
: ${INSTALL_PACKAGES_MP2_STARTER_PACKAGE:=0} 
: ${INSTALL_PACKAGES_MP2_SDK_x86_64:=0} 
: ${INSTALL_PACKAGES_MP2_DEV_PACKAGE_SRC:=0} 

: ${INSTALL_PACKAGES_T_FA_SRC:=0} 
: ${INSTALL_PACKAGES_T_FA_GIT:=0} 

: ${INSTALL_PACKAGES_U_BOOT_SRC:=0} 
: ${INSTALL_PACKAGES_U_BOOT_GIT:=0} 

: ${INSTALL_PACKAGES_OPTEE_SRC:=0} 
: ${INSTALL_PACKAGES_OPTEE_GIT:=0} 

: ${INSTALL_PACKAGES_KERNEL_SRC:=0} 
: ${INSTALL_PACKAGES_KERNEL_GIT:=0} 

: ${INSTALL_PACKAGES_GCNANO_SRC:=0} 
: ${INSTALL_PACKAGES_GCNANO_GIT:=0} 

: ${INSTALL_PACKAGES_MP2_EXTERNAL_DT:=0} 

: ${INSTALL_PACKAGE_MP2_FWDDR:=0} 



: ${INSTALL_PACKAGES_FIP_ARTIFACT_CP:=0} 

####TF-a

: ${TF_A_CMD_LINE:=}
: ${CLEAN_PACKAGES_T_FA_SRC=0} 
: ${BUILD_PACKAGES_T_FA_SRC:=0} 
: ${CLEAN_PACKAGES_T_FA_GIT=0} 
: ${BUILD_PACKAGES_T_FA_GIT:=0} 

####U-Boot

: ${U_BOOT_CMD_LINE:=} 
: ${CLEAN_PACKAGES_U_BOOT_SRC:=0} 
: ${BUILD_PACKAGES_U_BOOT_SRC:=0} 
: ${CLEAN_PACKAGES_U_BOOT_GIT:=0} 
: ${BUILD_PACKAGES_U_BOOT_GIT:=0} 

####OPTEE

: ${OPTEE_CMD_LINE:=} 

: ${CLEAN_PACKAGES_OPTEE_SRC:=0} 
: ${BUILD_PACKAGES_OPTEE_SRC:=0} 
: ${CLEAN_PACKAGES_OPTEE_GIT:=0} 
: ${BUILD_PACKAGES_OPTEE_GIT:=0} 

: ${CLEAN_PACKAGES_FIP_MP1:=0} 
: ${BUILD_PACKAGES_FIP_MP1:=0} 

: ${CLEAN_PACKAGES_FIP_MP2:=0} 
: ${BUILD_PACKAGES_FIP_MP2:=0} 

####Linux kernel
LINUX_MP1_CMD_LINE_ARCH="arm"
LINUX_MP2_CMD_LINE_ARCH="arm64"
LINUX_MP1_CMD_LINE_DEFCONFIG='multi_v7_defconfig'
LINUX_MP2_CMD_LINE_DEFCONFIG='defconfig'

: ${LINUX_MP1_CMD_LINE:="ARCH=arm uImage vmlinux dtbs LOADADDR=0xC2000040"} 
: ${LINUX_MP2_CMD_LINE:="ARCH=arm64 Image.gz  vmlinux dtbs LOADADDR=0xC2000040  KBUILD_EXTDTS=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/${EXTDT_DIRECTORY_NAME}/linux"} 

: ${CONFIGURE_PACKAGES_KERNEL_SRC:=0} 
: ${CLEAN_PACKAGES_KERNEL_SRC:=0} 
: ${BUILD_PACKAGES_KERNEL_SRC:=0} 
: ${CLEAN_PACKAGES_KERNEL_MODULES_SRC:=0} 
: ${BUILD_PACKAGES_KERNEL_MODULES_SRC:=0} 

: ${CONFIGURE_PACKAGES_KERNEL_GIT:=0} 
: ${CLEAN_PACKAGES_KERNEL_GIT:=0} 
: ${BUILD_PACKAGES_KERNEL_GIT:=0} 
: ${CLEAN_PACKAGES_KERNEL_MODULES_GIT:=0} 
: ${BUILD_PACKAGES_KERNEL_MODULES_GIT:=0} 

####GC nano

: ${GCNANO_CMD_LINE:='SOC_PLATFORM=st-'} 
: ${CLEAN_PACKAGES_GCNANO_SRC:=0} 
: ${BUILD_PACKAGES_GCNANO_SRC:=0} 
: ${CLEAN_PACKAGES_GCNANO_GIT:=0} 
: ${BUILD_PACKAGES_GCNANO_GIT:=0} 

: ${INSTALL_DISTRIBUTION_PACKAGES_MP1:=0} 
: ${INSTALL_DISTRIBUTION_PACKAGES_MP2:=0} 


######################### VM additionnal install and STM32 tool install
: ${INSTALL_TOOLS:=0} 
: ${INSTALL_TOOL_DIR:=0} 
: ${INSTALL_TA_EXAMPLES:=0} 
: ${BUILD_TA_EXAMPLES:=0} 
: ${INSTALL_GDB_SCRIPTS:=0} 
: ${INSTALL_CUBEMP1:=0} 
: ${INSTALL_CUBEMP13:=0} 
: ${INSTALL_STM32DDRFW_UTIL:=0} 
: ${INSTALL_TOOLS_CUBEPROG:=0} 
: ${INSTALL_TOOLS_CUBEMX:=0} 
: ${INSTALL_TOOLS_CUBEIDE:=0} 
: ${INSTALL_TOOLS_DESKTOP_ICONS:=0} 
#: ${OUTPUT_FILE:=/tmp/my_output.txt} 
: ${OUTPUT_FILE:=/dev/stdout} 

#===========================================================
# VM install from PC pre requisites
# Commands for release OpenSTLinux_v5 
#===========================================================
if [[(${INSTALL_VM} -eq 1)]];
then
echo "install VM for release OpenSTLinux${OSTL_VERSION}" 
sudo apt-get update
sudo apt-get install gawk wget git diffstat unzip texinfo gcc-multilib  chrpath socat cpio python3 python3-pip python3-pexpect 
sudo apt-get install xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint xterm bsdmainutils
sudo apt-get install libssl-dev libgmp-dev libmpc-dev lz4 zstd
 
#for Developper package
sudo apt-get install build-essential libncurses-dev libncurses5 libyaml-dev libssl-dev 

#for Distrubtion package
sudo apt install python-is-python3
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo

#for tools
sudo apt-get install coreutils bsdmainutils sed curl bc lrzsz corkscrew cvs subversion mercurial nfs-common nfs-kernel-server libarchive-zip-perl dos2unix texi2html libxml2-utils

#additional install (not in wiki article)
sudo apt-get install minicom net-tools git-lfs
sudo locale-gen 'en_US.UTF-8'
sudo update-locale 
sudo adduser osboxes disk
sudo adduser osboxes tty
sudo adduser osboxes dialout
fi
#===========================================================

#===========================================================
# VM package install from developer package
#===========================================================


if [[(${INSTALL_PACKAGES_DIR} -eq 1)]];
then
echo "install packages dir"
source install_packages.sh
fi

if [[(${INSTALL_PACKAGES_MP1} -eq 1)]];
then
echo "install packages mp1"
INSTALL_MPU=mp1
OSTL_DEV_PACKAGE_SRC_DIR=arm-ostl-linux-gnueabi
OSTL_DEV_PACKAGE_ENV_SETUP=environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi
SDK_NAME=SDK_MP1_x86_64
LINUX_CMD_LINE=${LINUX_MP1_CMD_LINE}
LINUX_CMD_LINE_ARCH=${LINUX_MP1_CMD_LINE_ARCH}
LINUX_CMD_LINE_DEFCONFIG=${LINUX_MP1_CMD_LINE_DEFCONFIG}
GCNANO_CMD_LINE='SOC_PLATFORM=st-mp1'
GCNANO_VERSION=6.4.15-stm32mp1-r1-r0
GCNANO_DIR=6.4.15-stm32mp1-r1
FIP_ARTIFACT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/FIP_artifacts
echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY} 
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}
source install_packages.sh
fi

if [[(${INSTALL_PACKAGES_MP2} -eq 1)]];
then
echo "install packages mp2"
INSTALL_MPU=mp2
SDK_NAME=SDK_MP2_x86_64
OSTL_DEV_PACKAGE_SRC_DIR=aarch64-ostl-linux
OSTL_DEV_PACKAGE_ENV_SETUP=environment-setup-cortexa35-ostl-linux
LINUX_CMD_LINE=${LINUX_MP2_CMD_LINE}
LINUX_CMD_LINE_ARCH=${LINUX_MP2_CMD_LINE_ARCH}
LINUX_CMD_LINE_DEFCONFIG=${LINUX_MP2_CMD_LINE_DEFCONFIG}
GCNANO_CMD_LINE='SOC_PLATFORM=st-mp2'
GCNANO_VERSION=6.4.15-stm32mp2-r1-r0
GCNANO_DIR=6.4.15-stm32mp2-r1
FIP_ARTIFACT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/FIP_artifacts
EXTDT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/${EXTDT_DIRECTORY_NAME}
FWDDR_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/stm32mp-ddr-phy-${FWDDR_VERSION}/stm32mp-ddr-phy-${FWDDR_DIR_NAME}


echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "export EXTDT_DIR=$EXTDT_DIRECTORY"
echo "export FWDDR_DIR=$FWDDR_DIRECTORY"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY} 
export EXTDT_DIR=${EXTDT_DIRECTORY}
export FWDDR_DIR=${FWDDR_DIRECTORY}
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}
source install_packages.sh
fi

if [[(${BUILD_PACKAGES_FIP_MP1} -eq 1)]];
then
INSTALL_MPU=mp1
OSTL_DEV_PACKAGE_SRC_DIR=arm-ostl-linux-gnueabi
OSTL_DEV_PACKAGE_ENV_SETUP=environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi
SDK_NAME=SDK_MP1_x86_64
GCNANO_CMD_LINE='SOC_PLATFORM=st-mp1'
GCNANO_VERSION=6.4.15-stm32mp1-r1-r0
GCNANO_DIR=6.4.15-stm32mp1-r1
FIP_ARTIFACT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/FIP_artifacts
echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY} 
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}

BUILD_PACKAGES_T_FA_SRC=1
BUILD_PACKAGES_U_BOOT_SRC=0
BUILD_PACKAGES_OPTEE_SRC=0

cd $SHARED_DIR
source install_packages.sh
BUILD_PACKAGES_T_FA_SRC=0
BUILD_PACKAGES_U_BOOT_SRC=1
BUILD_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
BUILD_PACKAGES_T_FA_SRC=0
BUILD_PACKAGES_U_BOOT_SRC=0
BUILD_PACKAGES_OPTEE_SRC=1
cd $SHARED_DIR
source install_packages.sh
fi

if [[(${CLEAN_PACKAGES_FIP_MP1} -eq 1)]];
then
INSTALL_MPU=mp1
OSTL_DEV_PACKAGE_SRC_DIR=arm-ostl-linux-gnueabi
OSTL_DEV_PACKAGE_ENV_SETUP=environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi
SDK_NAME=SDK_MP1_x86_64
GCNANO_CMD_LINE='SOC_PLATFORM=st-mp1'
GCNANO_VERSION=6.4.15-stm32mp1-r1-r0
GCNANO_DIR=6.4.15-stm32mp1-r1
FIP_ARTIFACT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/FIP_artifacts
echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY} 
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}
CLEAN_PACKAGES_T_FA_SRC=1
CLEAN_PACKAGES_U_BOOT_SRC=0
CLEAN_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
CLEAN_PACKAGES_T_FA_SRC=0
CLEAN_PACKAGES_U_BOOT_SRC=1
CLEAN_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
CLEAN_PACKAGES_T_FA_SRC=0
CLEAN_PACKAGES_U_BOOT_SRC=0
CLEAN_PACKAGES_OPTEE_SRC=1
cd $SHARED_DIR
source install_packages.sh
fi

if [[(${BUILD_PACKAGES_FIP_MP2} -eq 1)]];
then
INSTALL_MPU=mp2
OSTL_DEV_PACKAGE_SRC_DIR=aarch64-ostl-linux
OSTL_DEV_PACKAGE_ENV_SETUP=environment-setup-cortexa35-ostl-linux
SDK_NAME=SDK_MP2_x86_64
GCNANO_CMD_LINE='SOC_PLATFORM=st-mp2'
GCNANO_VERSION=6.4.15-stm32mp1-r1-r0
GCNANO_DIR=6.4.15-stm32mp1-r1
FIP_ARTIFACT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/FIP_artifacts
EXTDT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/${EXTDT_DIRECTORY_NAME}
FWDDR_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/stm32mp-ddr-phy-${FWDDR_VERSION}/stm32mp-ddr-phy-${FWDDR_DIR_NAME}

echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "export EXTDT_DIR=$EXTDT_DIRECTORY"
echo "export FWDDR_DIR=$FWDDR_DIRECTORY"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY} 
export EXTDT_DIR=${EXTDT_DIRECTORY}
export FWDDR_DIR=${FWDDR_DIRECTORY}
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}
BUILD_PACKAGES_T_FA_SRC=1
BUILD_PACKAGES_U_BOOT_SRC=0
BUILD_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
BUILD_PACKAGES_T_FA_SRC=0
BUILD_PACKAGES_U_BOOT_SRC=1
BUILD_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
BUILD_PACKAGES_T_FA_SRC=0
BUILD_PACKAGES_U_BOOT_SRC=0
BUILD_PACKAGES_OPTEE_SRC=1
cd $SHARED_DIR
source install_packages.sh
fi

if [[(${CLEAN_PACKAGES_FIP_MP2} -eq 1)]];
then
INSTALL_MPU=mp2
OSTL_DEV_PACKAGE_SRC_DIR=aarch64-ostl-linux
OSTL_DEV_PACKAGE_ENV_SETUP=environment-setup-cortexa35-ostl-linux
SDK_NAME=SDK_MP2_x86_64
GCNANO_CMD_LINE='SOC_PLATFORM=st-mp2'
GCNANO_VERSION=6.4.15-stm32mp1-r1-r0
GCNANO_DIR=6.4.15-stm32mp1-r1
FIP_ARTIFACT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/FIP_artifacts
EXTDT_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/${EXTDT_DIRECTORY_NAME}
FWDDR_DIRECTORY=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/stm32mp-ddr-phy-${FWDDR_VERSION}/stm32mp-ddr-phy-${FWDDR_DIR_NAME}

echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "export EXTDT_DIR=$EXTDT_DIRECTORY"
echo "export FWDDR_DIR=$FWDDR_DIRECTORY"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY} 
export EXTDT_DIR=${EXTDT_DIRECTORY}
export FWDDR_DIR=${FWDDR_DIRECTORY}
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}
CLEAN_PACKAGES_T_FA_SRC=1
CLEAN_PACKAGES_U_BOOT_SRC=0
CLEAN_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
CLEAN_PACKAGES_T_FA_SRC=0
CLEAN_PACKAGES_U_BOOT_SRC=1
CLEAN_PACKAGES_OPTEE_SRC=0
cd $SHARED_DIR
source install_packages.sh
CLEAN_PACKAGES_T_FA_SRC=0
CLEAN_PACKAGES_U_BOOT_SRC=0
CLEAN_PACKAGES_OPTEE_SRC=1
cd $SHARED_DIR
source install_packages.sh
fi

#===========================================================

#===========================================================
# VM additionnal install and STM32 tool install
#===========================================================

if [[(${INSTALL_TOOLS} -eq 1)]];
then
source install_tools.sh
fi
#===========================================================

