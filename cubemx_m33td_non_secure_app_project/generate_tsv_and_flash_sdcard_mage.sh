#!/bin/bash

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
######################### VM package install from developer package

OLD_PWD=${PWD}

source ../configure_OpenSTLinux_release_install.sh

source configure_custom_param_cubemx_non_secure_app.sh


GENERATE_TSV=1
GENERATE_RAW_IMAGE=0
SDCARD_FLASH_RAW_IMAGE=0
SDCARD_FLASH_TSV_WITH_CUBEPROG=1

SDCARD_FLASH_PARTITION=mmcblk0
MPU_NAME=mp2
FLASH_IMAGE_NAME=FlashLayout_sdcard_stm32mp257f-ev1-cm33tdcid-ostl-optee
IMAGE_DIR_NAME=stm32mp2-m33td
BL2_BINARY_PATH=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}/Middlewares/Third_Party/trusted-firmware-m/config_default/bin/bl2.stm32
DEST_BL2_BINARY_NAME=arm-trusted-firmware-m/bl2/my_bl2-stm32mp257f-ev1-cm33tdcid-ostl-sdcard.stm32
DDR_BINARY_PATH=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_VERSION}/Middlewares/Third_Party/trusted-firmware-m/config_default/bin/ddr_phy_signed.bin
DEST_DDR_BINARY_NAME=m33-firmware/my_ddr_phy-stm32mp257f-ev1-cm33tdcid-ostl-sdcard_Signed.bin
STARTER_APP_BINARY_PATH=${CUSTOM_PRJ_PATH}/CM33/NonSecure/Debug/${CUSTOM_DTS_NAME}_CM33_NonSecure_tfm_s_ns_signed.bin
DEST_STARTER_APP_BINARY_NAME=m33-firmware/my_tfm-${CUSTOM_DTS_NAME}-stm32mp257f-ev1-cm33tdcid-ostl-sdcard-sdcard_s_ns_Signed.bin 
TSV_NAME=${FLASH_IMAGE_NAME}.tsv
MY_TSV_NAME=my_test_${FLASH_IMAGE_NAME}.tsv
MY_FLASH_IMAGE_NAME=my_test_${FLASH_IMAGE_NAME}



echo "generate the tsv, the raw image (sdcard only), flash raw image with sdcard reader)"
echo "can configure options in the script"
echo "GENERATE_TSV generate tsv and copy binaries from m33td starter app"
echo "GENERATE_RAW_IMAGE generate raw image from the tsv (for sdcard only)"
echo "SDCARD_FLASH_RAW_IMAGE to flash the raw image on sdcard using sdcard reader,"
echo "	check sdcard partition with lsblk"
echo "	configure SDCARD_FLASH_PARTITION"
echo "	uncomment or copy/paste the commands to flash with dd"
echo "	(https://wiki.st.com/stm32mpu/wiki/How_to_populate_the_SD_card_with_dd_command)"

if [[(${GENERATE_TSV} -eq 1)]];
then

echo "cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}/flashlayout_st-image-weston/optee/"
cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}/flashlayout_st-image-weston/optee/

echo "create new tsv file ${MY_TSV_NAME}"
echo "cp ${TSV_NAME} ${MY_TSV_NAME}"
cp ${TSV_NAME} ${MY_TSV_NAME}

echo "replace binarie names in tsv"
sed -i "s/bl2-/my_bl2-/" ${MY_TSV_NAME}
sed -i "s/ddr_phy-/my_ddr_phy-/" ${MY_TSV_NAME}
sed -i "s/tfm-starterapp-/my_tfm-${CUSTOM_DTS_NAME}-/" ${MY_TSV_NAME}

echo "copy binaries to starter package"

cp ${BL2_BINARY_PATH} ../../${DEST_BL2_BINARY_NAME}
cp ${DDR_BINARY_PATH} ../../${DEST_DDR_BINARY_NAME}
cp ${STARTER_APP_BINARY_PATH} ../../${DEST_STARTER_APP_BINARY_NAME}

fi

if [[(${GENERATE_RAW_IMAGE} -eq 1)]];
then
echo "generate raw image for sdcard"
echo "cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}"
cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}/

echo "cd scripts"
cd scripts

echo "./create_sdcard_from_flashlayout.sh ../flashlayout_st-image-weston/optee/${MY_TSV_NAME}"
./create_sdcard_from_flashlayout.sh ../flashlayout_st-image-weston/optee/${MY_TSV_NAME}

fi

if [[(${SDCARD_FLASH_RAW_IMAGE} -eq 1)]];
then
#https://wiki.st.com/stm32mpu/wiki/How_to_populate_the_SD_card_with_dd_command
echo "populate_the_SD_card_with_dd_command"
echo "cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}"
cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}/


echo "    sudo umount \`lsblk --list | grep ${DEFAULT_DEVICE} | grep part | gawk '{ print \$7 }' | tr '\\n' ' '\`"
echo "sudo dd if=${MY_FLASH_IMAGE_NAME}.raw of=/dev/${SDCARD_FLASH_PARTITION} bs=8M conv=fdatasync status=progress"

echo "###################"
echo "configure SDCARD_FLASH_PARTITION (check partition name using lsblk)"
echo "uncomment dd command in this script"
echo "###################"

#sudo umount `lsblk --list | grep ${SDCARD_FLASH_PARTITION} | grep part | gawk '{ print $7 }' | tr '\n' ' '`
#sudo dd if=${MY_FLASH_IMAGE_NAME}.raw of=/dev/${SDCARD_FLASH_PARTITION} bs=8M conv=fdatasync status=progress

fi

if [[(${SDCARD_FLASH_TSV_WITH_CUBEPROG} -eq 1)]];
then
cd /local/OSTL-v${OSTL_VERSION}/Starter-Package/stm32${MPU_NAME}-m33td-$OSTL_FLASH_TAG/images/${IMAGE_DIR_NAME}/
${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI -c port=usb1 -w ./flashlayout_st-image-weston/optee/${MY_TSV_NAME}
fi

cd ${OLD_PWD}
