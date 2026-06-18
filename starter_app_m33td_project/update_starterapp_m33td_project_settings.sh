#!/bin/bash

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
######################### VM package install from developer package

OLD_PWD=${PWD}


COPY_EV1_BOARD_DTS_TO_CUSTOM_BOARD_DTS=1

source ../configure_OpenSTLinux_release_install.sh


CUSTOM_DTS_NAME="my_ev1_mp2_default"
CUSTOM_DTS_PATH="${HOME}/${CUSTOM_DTS_NAME}"
DTS_PATH_DEST="${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}/Utilities/dt-stm32mp/stm32mp2/m33-td/"


STARTER_APP_M33TD_PATH=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}/Projects/STM32MP257F-EV1/Demonstrations/StarterApp_M33TD
STARTER_APP_M33TD_CPROJECT_PATH=${STARTER_APP_M33TD_PATH}/STM32CubeIDE/CM33/StarterApp_M33TD_CM33_trusted-firmware-m/
###start from ev1 dts"
if [[(${COPY_EV1_BOARD_DTS_TO_CUSTOM_BOARD_DTS} -eq 1)]];
then
EV1_DTS_NAME="stm32mp257f-ev1-cm33tdcid-ostl"
[ -d ${CUSTOM_DTS_PATH}/ ] && echo "${CUSTOM_DTS_PATH}/ already existe" || mkdir ${CUSTOM_DTS_PATH}/ ; sudo chmod -R 777 ${CUSTOM_DTS_PATH}/
[ -d ${CUSTOM_DTS_PATH}/tfm ] && echo "${CUSTOM_DTS_PATH}/tfm already existe" || mkdir ${CUSTOM_DTS_PATH}/tfm ; sudo chmod -R 777 ${CUSTOM_DTS_PATH}/tfm
[ -d ${CUSTOM_DTS_PATH}/mcuboot ] && echo "${CUSTOM_DTS_PATH}/mcuboot already existe" || mkdir ${CUSTOM_DTS_PATH}/mcuboot ; sudo chmod -R 777 ${CUSTOM_DTS_PATH}/mcuboot


cp ${DTS_PATH_DEST}/tfm/${EV1_DTS_NAME}-ns.dts ${CUSTOM_DTS_PATH}/tfm/${CUSTOM_DTS_NAME}_tfm-ns.dts
cp ${DTS_PATH_DEST}/tfm/${EV1_DTS_NAME}-sdcard-s.dts ${CUSTOM_DTS_PATH}/tfm/${CUSTOM_DTS_NAME}_tfm-sdcard-s.dts
cp ${DTS_PATH_DEST}/mcuboot/${EV1_DTS_NAME}-sdcard-bl2.dts  ${CUSTOM_DTS_PATH}/mcuboot/${CUSTOM_DTS_NAME}_mcuboot-sdcard-bl2.dts 

fi

echo "====copy device trees to tfm ===="

echo "cp -a ${CUSTOM_DTS_PATH}/mcuboot/* ${DTS_PATH_DEST}/mcuboot/"

cp -a ${CUSTOM_DTS_PATH}/mcuboot/* ${DTS_PATH_DEST}/mcuboot/

echo "cp -a ${CUSTOM_DTS_PATH}/tfm/* ${DTS_PATH_DEST}/tfm"

cp -a ${CUSTOM_DTS_PATH}/tfm/* ${DTS_PATH_DEST}/tfm/


echo "====starter app .cproject===="

echo "${STARTER_APP_M33TD_CPROJECT_PATH}/.cproject"

echo "cd ${STARTER_APP_M33TD_CPROJECT_PATH}"
cd ${STARTER_APP_M33TD_CPROJECT_PATH}

MY_DTS_NS="${CUSTOM_DTS_NAME}_tfm-ns.dts"
MY_DTS_S="${CUSTOM_DTS_NAME}_tfm-sdcard-s.dts"
MY_DTS_MCU_BOOT="${CUSTOM_DTS_NAME}_mcuboot-sdcard-bl2.dts"


echo "====replace cmake option in misc_command in .cproject==="

CMAKE_SETTINGS_CMD="<misc_command> -DTFM_PLATFORM=stm\/stm32mp257f_ev1 -DTFM_TOOLCHAIN_FILE=toolchain_GNUARM.cmake -DSTM32_BOOT_DEV=sdmmc1 -DTFM_PROFILE=profile_medium -DSTM32_M33TDCID=ON -DCMAKE_BUILD_TYPE=Relwithdebinfo -DNS=OFF -DDTS_EXT_DIR=..\/..\/..\/..\/..\/..\/..\/..\/Utilities\/dt-stm32mp -DDTS_BOARD_BL2=stm32mp2\/m33-td\/mcuboot\/${MY_DTS_MCU_BOOT} -DDTS_BOARD_S=stm32mp2\/m33-td\/tfm\/${MY_DTS_S} -DDTS_BOARD_NS=stm32mp2\/m33-td\/tfm\/${MY_DTS_NS} <\/misc_command>"


#echo "CMAKE_SETTINGS_CMD ${CMAKE_SETTINGS_CMD}" 
sed -i "s/<misc_command.*/${CMAKE_SETTINGS_CMD}/" .cproject



cd ${OLD_PWD}

