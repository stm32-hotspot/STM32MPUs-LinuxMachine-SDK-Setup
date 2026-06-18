#!/bin/bash -v
#Add in StarterApp_M33TD_BM_CM33_NonSecure project "A35_BM" in MCU GCC Compiler > Preprocessor 

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
######################### VM package install from developer package

OLD_PWD=${PWD}

source ../configure_OpenSTLinux_release_install.sh
BOARD=STM32MP215F-DK
export CUBEMP2_BM_DIR=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}
export PJR_NAME=Template_StarterApp
export CUBEMP2_StarterAPP_BM_DIR=${CUBEMP2_BM_DIR}/Projects/${BOARD}/Templates/${PJR_NAME}_M33TD

export CUSTOM_EXT_LOADER_DIR=${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/Custom_Binaries/SD_Ext_Loader/aarch32
export TFPM_BIN_DIR=${CUBEMP2_BM_DIR}/Middlewares/Third_Party/trusted-firmware-m/config_default/bin





if [ -d ${CUSTOM_EXT_LOADER_DIR} ]
then
echo "folder ${CUSTOM_EXT_LOADER_DIR} present"
else
echo "mkdir -p ${CUSTOM_EXT_LOADER_DIR}"
mkdir -p ${CUSTOM_EXT_LOADER_DIR}
cp  -v ${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/Prebuild_Binaries/SD_Ext_Loader/aarch32/* ${CUSTOM_EXT_LOADER_DIR}
fi
echo ""
echo "Update binaires "
echo "cd ${CUSTOM_EXT_LOADER_DIR}"
echo ""
cd ${CUSTOM_EXT_LOADER_DIR}
cp -v ${TFPM_BIN_DIR}/ddr_phy_signed.bin .
echo ""
cp -v ${TFPM_BIN_DIR}/bl2.stm32 .
echo ""
cp -v ${TFPM_BIN_DIR}/ca35_fw_signed.bin .
echo ""
cp -v ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/${PJR_NAME}_build_ns/${PJR_NAME}_M33TD_CM33_NonSecure_tfm_s_ns_signed.bin ${CUSTOM_EXT_LOADER_DIR}/tfm_s_ns_signed.bin
echo ""
if [ -f ${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/SD_Ext_Loader/STM32CubeIDE/Debug_aarch32/SD_Ext_Loader_A35.bin ] 
then
cp -v ${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/SD_Ext_Loader/STM32CubeIDE/Debug_aarch32/SD_Ext_Loader_A35.bin .
echo ""
fi
if [ -f ${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/External_Mem_Loader/STM32CubeIDE/Debug_aarch32/External_Mem_Loader_A35.bin ]
then
cp -v ${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/External_Mem_Loader/STM32CubeIDE/Debug_aarch32/External_Mem_Loader_A35.bin .
fi

cd ${OLD_PWD}



