#!/bin/bash

export INSTALL_PACKAGES_MP1=1
export INSTALL_PACKAGES_KERNEL_GIT=0
export INSTALL_PACKAGES_KERNEL_SRC=1

export CLEAN_PACKAGES_KERNEL_SRC=0
export CONFIGURE_PACKAGES_KERNEL_SRC=1
export BUILD_PACKAGES_KERNEL_SRC=1


export CLEAN_PACKAGES_U_BOOT_GIT=0
export CONFIGURE_PACKAGES_KERNEL_GIT=0
export BUILD_PACKAGES_U_BOOT_GIT=0

export CLEAN_PACKAGES_KERNEL_MODULES_SRC=0
export BUILD_PACKAGES_KERNEL_MODULES_SRC=0

export CLEAN_PACKAGES_KERNEL_MODULES_GIT=0
export BUILD_PACKAGES_KERNEL_MODULES_GIT=0

#export INSTALL_VM_VERBOSE_ONLY='set -n'
export OUTPUT_FILE:=/tmp/my_output.txt
export OUTPUT_FILE:=/dev/stdout


export LINUX_MP1_CMD_LINE="ARCH=arm uImage vmlinux dtbs LOADADDR=0xC2000040"
export LINUX_MP2_CMD_LINE="ARCH=arm64 Image.gz  vmlinux dtbs LOADADDR=0xC2000040  KBUILD_EXTDTS=${EXTDT_DIRECTORY}/linux"

./install_VM_OpenSTLinux_v5_1.sh

echo "------------------------------------------------------------" 
echo " you can configure variables in this script for kernel build"
echo " example INSTALL_PACKAGES_KERNEL_SRC for install/reinstall the kernel sources"
echo "------------------------------------------------------------" 

