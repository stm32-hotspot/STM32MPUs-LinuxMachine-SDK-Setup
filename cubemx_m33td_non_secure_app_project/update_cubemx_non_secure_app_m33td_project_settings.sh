#!/bin/bash

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
######################### VM package install from developer package

OLD_PWD=${PWD}


source ../configure_OpenSTLinux_release_install.sh

source configure_custom_param_cubemx_non_secure_app.sh

#arm_trusted fw configuration cmake settings
echo "=====trusted-firmware-m cmake settings Other options======="
echo "trusted-firmware-m .cproject"
echo "${TRUSTED_FW_PATH}/.cproject"

CMAKE_SETTINGS_DEGUG_CMD="<misc_command>-DDEBUG_AUTHENTICATION=FULL -DTFM_PLATFORM=${CUSTOM_DTS_PATH}\/CM33\/PlatformTF-M -DTFM_TOOLCHAIN_FILE=toolchain_GNUARM.cmake  -DTFM_PROFILE=profile_medium  -DSTM32_M33TDCID=ON  -DCMAKE_BUILD_TYPE=Relwithdebinfo  -DSTM32_BOOT_DEV=sdmmc1 -DDTS_EXT_DIR=${CUSTOM_DTS_PATH}\/CM33\/DeviceTree -DDTS_BOARD_BL2=${CUSTOM_DTS_NAME}\/mcuboot\/stm32mp257f-${CUSTOM_DTS_NAME}-mx.dts  -DDTS_BOARD_S=${CUSTOM_DTS_NAME}\/tf-m\/stm32mp257f-${CUSTOM_DTS_NAME}-mx.dts <\/misc_command>"

CMAKE_SETTINGS_CMD="<misc_command>-DTFM_PLATFORM=${CUSTOM_DTS_PATH}\/CM33\/PlatformTF-M -DTFM_TOOLCHAIN_FILE=toolchain_GNUARM.cmake  -DTFM_PROFILE=profile_medium  -DSTM32_M33TDCID=ON  -DCMAKE_BUILD_TYPE=Relwithdebinfo  -DSTM32_BOOT_DEV=sdmmc1 -DDTS_EXT_DIR=${CUSTOM_DTS_PATH}\/CM33\/DeviceTree -DDTS_BOARD_BL2=${CUSTOM_DTS_NAME}\/mcuboot\/stm32mp257f-${CUSTOM_DTS_NAME}-mx.dts  -DDTS_BOARD_S=${CUSTOM_DTS_NAME}\/tf-m\/stm32mp257f-${CUSTOM_DTS_NAME}-mx.dts <\/misc_command>"


echo "cd ${TRUSTED_FW_PATH}"
cd ${TRUSTED_FW_PATH}

sed -i "s/.*misc_command.*/${CMAKE_SETTINGS_CMD}/" .cproject

#non secure configuration
echo "=====non secure application project settings========"
echo "${CUSTOM_PRJ_PATH}/CM33/NonSecure/.cproject"


echo "cd ${CUSTOM_PRJ_PATH}/CM33/NonSecure/"
cd ${CUSTOM_PRJ_PATH}/CM33/NonSecure/

echo "cp linker script stm32mp2xx_DDR_m33_ns.ld from m33td starter app"
cp ${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}//Projects/STM32MP257F-EV1/Demonstrations/StarterApp_M33TD/stm32mp2xx_DDR_m33_ns.ld ${CUSTOM_PRJ_PATH}/CM33/NonSecure/




STARTUP_FILE="${CUSTOM_PRJ_PATH}/CM33/NonSecure/Core/Startup/startup_stm32mp257faix.s"

#echo "===update starter file old startuo file $STARTUP_FILE"

#if [ -f "$STARTUP_FILE" ]; then

#echo "cp startup binary startup_stm32mp257cxx_m33.s"
#mv  ${STARTUP_FILE} ${STARTUP_FILE}_old
#cp ${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}/./Projects/STM32MP257F-EV1/Applications/OpenAMP/OpenAMP_TTY_echo/startup_stm32mp257cxx_m33.s ${CUSTOM_PRJ_PATH}/CM33/NonSecure/Core/Startup
#fi


echo "====update linker script settings to .cproject===="

sed -i "s/STM32MP257FAIX_RAM.ld/stm32mp2xx_DDR_m33_ns.ld/" .cproject

echo "============================================="
echo "====Do not forget to configure manually===="
echo "update target install in cmake setting behavior"
echo "update -j1 in non secure app post build comment"
echo "====Check debug options===="
echo "DDEBUG_AUTHENTICATION for bl2 breakpoint in trusted firmware m="
echo "DEBUG define in build options for non secure app to stop in hile loop at statup===="
echo "====Do not forget to generate again project from STM32CubeMx and rebuild trusted firmware m before build non secure app"

cd ${OLD_PWD}

