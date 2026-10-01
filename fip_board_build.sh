

#!/bin/bash

: ${INSTALL_MP1_BOARD:=0} 
: ${INSTALL_MP2_BOARD:=0} 
: ${CLEAN_BSP_PACKAGES_FOR_FIP:=0} 
: ${INSTALL_BSP_PACKAGES_FOR_FIP:=0} 
: ${BUILD_PACKAGES_FIP_FROM_VM_INSTALL:=0}
: ${BUILD_PACKAGES_FIP_FROM_SCRIPTS:=0}

export INSTALL_PACKAGES_MP1=0
export INSTALL_PACKAGES_MP2=0
if [[(${INSTALL_MP2_BOARD} -eq 1)]];
then
export INSTALL_MPU=mp2
export INSTALL_PACKAGES_MP2=1
fi
if [[(${INSTALL_MP1_BOARD} -eq 1)]];
then
export INSTALL_PACKAGES_MP1=1
export INSTALL_MPU=mp1
fi
#export INSTALL_VM_VERBOSE_ONLY=1

####Clean previous fip
if [[(${CLEAN_BSP_PACKAGES_FOR_FIP} -eq 1)]];
then
export CLEAN_PACKAGES_FIP_MP1=0
export CLEAN_PACKAGES_FIP_MP2=0
if [[(${INSTALL_MP2_BOARD} -eq 1)]];
then
export CLEAN_PACKAGES_FIP_MP2=1
fi
if [[(${INSTALL_MP1_BOARD} -eq 1)]];
then
export CLEAN_PACKAGES_FIP_MP1=1
fi
./install_OpenSTLinux_release.sh
export CLEAN_PACKAGES_FIP_MP1=0
export CLEAN_PACKAGES_FIP_MP2=0
fi
####Copy default FIP artifact
####NOT NEEDED
###export INSTALL_PACKAGES_FIP_ARTIFACT_CP=0
###./install_OpenSTLinux_release.sh
###export INSTALL_PACKAGES_FIP_ARTIFACT_CP=0

####Install all bsp components first time with no parameter



if [[(${INSTALL_BSP_PACKAGES_FOR_FIP} -eq 1)]];
then

if [[(${INSTALL_MP2_BOARD} -eq 1)]];
then
export INSTALL_PACKAGES_MP2_EXTERNAL_DT=1
./install_OpenSTLinux_release.sh
export INSTALL_PACKAGES_MP2_EXTERNAL_DT=0
fi


if [[(${INSTALL_MP2_BOARD} -eq 1)]];
then

export INSTALL_PACKAGE_MP2_FWDDR=1
./install_OpenSTLinux_release.sh
export INSTALL_PACKAGE_MP2_FWDDR=0
fi

#re-install tf-a src
export INSTALL_PACKAGES_T_FA_SRC=1
./install_OpenSTLinux_release.sh
export INSTALL_PACKAGES_T_FA_SRC=0

#re-install u-boot src
export INSTALL_PACKAGES_U_BOOT_SRC=1
./install_OpenSTLinux_release.sh
export INSTALL_PACKAGES_U_BOOT_SRC=0

#re-install optee src
export INSTALL_PACKAGES_OPTEE_SRC=1
./install_OpenSTLinux_release.sh
export INSTALL_PACKAGES_OPTEE_SRC=0

fi

####Select FIP PACKAGE TO BUILD

export BUILD_PACKAGES_FIP_MP1=0
export BUILD_PACKAGES_FIP_MP2=0

if [[(${INSTALL_MP2_BOARD} -eq 1)]];
then
export BUILD_PACKAGES_FIP_MP2=1
fi
if [[(${INSTALL_MP1_BOARD} -eq 1)]];
then
export BUILD_PACKAGES_FIP_MP1=1
fi

####Build all bsp components first time with no parameter


if [[(${BUILD_PACKAGES_FIP_FROM_VM_INSTALL} -eq 1)]];
then
./install_OpenSTLinux_release.sh
fi

####Build then all bsp components second time with command line parameters for the board

export BUILD_PACKAGES_FIP_MP1=0
export BUILD_PACKAGES_FIP_MP2=0


if [[(${BUILD_PACKAGES_FIP_FROM_SCRIPTS} -eq 1)]];
then
if [[(${INSTALL_MP2_BOARD} -eq 1)]];
then
./tf-a-mp2-build.sh
./u-boot-mp2-build.sh
./optee-mp2-build.sh
fi

if [[(${INSTALL_MP1_BOARD} -eq 1)]];
then
./tf-a-mp1-build.sh
./u-boot-mp1-build.sh
./optee-mp1-build.sh
fi
fi




