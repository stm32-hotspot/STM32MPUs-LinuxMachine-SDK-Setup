#!/bin/bash v


OLD_PWD=${PWD}

source ../configure_OpenSTLinux_release_install.sh


BOARD=STM32MP215F-DK
export PJR_NAME=Template_StarterApp_M33TD
export CUBEMP2_StarterAPP_BM_DIR=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}/Projects/${BOARD}/Templates/${PJR_NAME}

if [ -f ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject.ori ] 
then
echo "${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject already patched"


else
echo "Patch in project settins Properties > C/C++ Build > Cmake Settings Other Option field in file ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject "
echo ""
cp -v ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject.ori

sed -Ei "s#<misc_command>([^<]*)</misc_command>#<misc_command>\1 -DSTM32_CA35_FW=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}/Projects/${BOARD}/Templates/Template_CA35_Secure/STM32CubeIDE/CA35/Secure/CA35_ARCH32_BM/Template_CA35_Secure.bin</misc_command>#g" ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject 

sed -i 's|-DDTS_BOARD_BL2=[^ ]*|-DDTS_BOARD_BL2=stm32mp2/m33-td/mcuboot/stm32mp215f-dk-cm33tdcid-bm-sdcard-bl2.dts|' ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject

sed -i 's|-DDTS_BOARD_S=[^ ]*|-DDTS_BOARD_S=stm32mp2/m33-td/tfm/stm32mp215f-dk-cm33tdcid-bm-sdcard-s.dts|' ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject

sed -i 's|-DDTS_BOARD_NS=[^ ]*|-DDTS_BOARD_NS=stm32mp2/m33-td/tfm/stm32mp215f-dk-cm33tdcid-bm-ns.dt|' ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject

sed -i 's|-DDTS_EXT_DIR=[^ ]*|-DDTS_EXT_DIR=../../../../../../../../Utilities/dt-stm32mp_BM|' ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/${PJR_NAME}_CM33_trusted-firmware-m/.cproject 

fi


