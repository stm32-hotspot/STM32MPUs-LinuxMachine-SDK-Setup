#!/bin/bash

#########install from wiki PC pre requisites
##########################################

echo "===================================================================================" 

echo "install developer package bsp components for release OpenSTLinux${OSTL_VERSION}" 

echo "===================================================================================" 

OLD_PWD=${PWD}

if [[(${INSTALL_PACKAGES_MP1} -eq 1)]];
then
MPU_NAME=mp1
fi

if [[(${INSTALL_PACKAGES_MP2} -eq 1)]];
then
MPU_NAME=mp2
fi


if [[(${INSTALL_PACKAGES_DIR} -eq 1)]];
then
echo "install developer package directory for release OpenSTLinux${OSTL_VERSION} ${INSTALL_DIR}" 
echo "sudo mkdir ${INSTALL_ROOT_DIR}" 
echo "sudo mkdir ${INSTALL_DIR}" 
echo "sudo mkdir ${INSTALL_DIR}/Starter-Package" 
echo "sudo mkdir ${INSTALL_DIR}/Developer-Package" 
echo "sudo mkdir ${INSTALL_DIR}/Distribution-Package" 
echo "sudo chmod -R 777 ${INSTALL_DIR}" 
${INSTALL_VM_VERBOSE_ONLY}
sudo mkdir ${INSTALL_ROOT_DIR}
sudo mkdir ${INSTALL_DIR}
sudo mkdir ${INSTALL_DIR}/Starter-Package
sudo mkdir ${INSTALL_DIR}/Developer-Package
sudo mkdir ${INSTALL_DIR}/Distribution-Package
sudo chmod -R 777 ${INSTALL_DIR}
sudo chown -R $USER  ${INSTALL_DIR}
echo "export SDK_ROOT=$INSTALL_DIR/Developer-Package" >> ${HOME}/.bashrc

fi

if [[(${INSTALL_PACKAGES_MP1_STARTER_PACKAGE} -eq 1)]];
then
#Starter package
#-----
echo "install starter package STM32MP1  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP1_STARTER_PACKAGE}" 
cd ${INSTALL_DIR}/Starter-Package
echo "${INSTALL_DIR}/Starter-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_STARTER_PACKAGE} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_STARTER_PACKAGE} ." 
${INSTALL_VM_VERBOSE_ONLY}
tar xvf ${OSTL_PACKAGES_MP1_STARTER_PACKAGE} > ${OUTPUT_FILE}
fi

if [[(${INSTALL_PACKAGES_MP2_STARTER_PACKAGE} -eq 1)]];
then
#Starter package
#-----
echo "install starter package STM32MP2  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP2_STARTER_PACKAGE}" 
cd ${INSTALL_DIR}/Starter-Package
echo "${INSTALL_DIR}/Starter-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_STARTER_PACKAGE} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_STARTER_PACKAGE} ." 
${INSTALL_VM_VERBOSE_ONLY}
tar xvf ${OSTL_PACKAGES_MP2_STARTER_PACKAGE} > ${OUTPUT_FILE}

fi

if [[(${INSTALL_PACKAGES_MP2_STARTER_PACKAGE_M33TD} -eq 1)]];
then
#Starter package
#-----
echo "install starter package STM32MP2  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP2_STARTER_PACKAGE_M33TD}" 
cd ${INSTALL_DIR}/Starter-Package
echo "${INSTALL_DIR}/Starter-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_STARTER_PACKAGE_M33TD} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_STARTER_PACKAGE_M33TD} ." 
${INSTALL_VM_VERBOSE_ONLY}
tar xvf ${OSTL_PACKAGES_MP2_STARTER_PACKAGE_M33TD} > ${OUTPUT_FILE}

fi




if [[(${INSTALL_PACKAGES_MP1_SDK_x86_64} -eq 1)]];
then
#SDK
#-----
#Install the SDK (look for wiki article" STM32MP1 Developer Package - SDK " open link to File:Linux.README.HOW TO.txt)
echo "install SDK x86_64 STM32MP1  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP1_SDK_x86_64}" 
cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_SDK_x86_64} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_SDK_x86_64} ." 
${INSTALL_VM_VERBOSE_ONLY}
tar xvf ${OSTL_PACKAGES_MP1_SDK_x86_64} > ${OUTPUT_FILE}
cd stm32${MPU_NAME}-${OSTL_TAG}/sdk
chmod +x st-image-weston-openstlinux-weston-stm32${MPU_NAME}.${OSTL_TOOL_CHAIN_x86_64_SETUP}
./st-image-weston-openstlinux-weston-stm32${MPU_NAME}.${OSTL_TOOL_CHAIN_x86_64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP1_x86_64

fi

if [[(${INSTALL_PACKAGES_MP2_SDK_x86_64} -eq 1)]];
then
#SDK
#-----
#Install the SDK (look for wiki article" STM32MP1 Developer Package - SDK " open link to File:Linux.README.HOW TO.txt)
echo "install SDK x86_64 STM32MP2  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP2_SDK_x86_64}" 
cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_SDK_x86_64} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_SDK_x86_64} ." 
${INSTALL_VM_VERBOSE_ONLY}
tar xvf ${OSTL_PACKAGES_MP2_SDK_x86_64} > ${OUTPUT_FILE}
cd stm32${MPU_NAME}-${OSTL_TAG}/sdk
chmod +x st-image-weston-openstlinux-weston-stm32${MPU_NAME}.${OSTL_TOOL_CHAIN_x86_64_SETUP}
./st-image-weston-openstlinux-weston-stm32${MPU_NAME}.${OSTL_TOOL_CHAIN_x86_64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP2_x86_64
echo "./st-image-weston-openstlinux-weston-stm32${MPU_NAME}.${OSTL_TOOL_CHAIN_x86_64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP2_x86_64"

fi



if [[(${INSTALL_PACKAGES_MP_DEV_PACKAGE_SRC} -eq 1)]];
then
#Unzip Sources
#-------------
echo "install SDK dev package sources STM32MP1  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP_DEV_PACKAGE_SRC}" 
cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP_DEV_PACKAGE_SRC} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP_DEV_PACKAGE_SRC} ."
${INSTALL_VM_VERBOSE_ONLY} 
tar xvf ${OSTL_PACKAGES_MP_DEV_PACKAGE_SRC} > ${OUTPUT_FILE}
fi





#How to build distribution package
#-------------------------------

#look for articles
#STM32MP1 Distribution Package
#STM32MP1 Distribution Package - OpenSTLinux distribution
if [[(${INSTALL_DISTRIBUTION_PACKAGES_MP1} -eq 1)]];
then
echo "install and build distribution package mp1"
cd ${INSTALL_DIR}/Distribution-Package
echo "cd ${INSTALL_DIR}/Distribution-Package"
echo "repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/${OSTL_TAG}"
echo "repo sync"
echo "DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh"
echo "bitbake --runall=fetch st-image-weston"
echo "bitbake -k st-image-weston"
${INSTALL_VM_VERBOSE_ONLY}
repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/${OSTL_TAG}
repo sync
DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh
bitbake --runall=fetch st-image-weston
bitbake -k st-image-weston
fi

if [[(${INSTALL_DISTRIBUTION_PACKAGES_MP2} -eq 1)]];
then
echo "install and build distribution package mp2"
cd ${INSTALL_DIR}/Distribution-Package
echo "cd ${INSTALL_DIR}/Distribution-Package"
echo "repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/${OSTL_TAG}"
echo "repo sync"
echo "DISTRO=openstlinux-weston MACHINE=stm32mp2 source layers/meta-st/scripts/envsetup.sh"
echo "bitbake --runall=fetch st-image-weston"
echo "bitbake -k st-image-weston"
${INSTALL_VM_VERBOSE_ONLY}
repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/${OSTL_TAG}
repo sync
DISTRO=openstlinux-weston MACHINE=stm32mp2 source layers/meta-st/scripts/envsetup.sh
bitbake --runall=fetch st-image-weston
bitbake -k st-image-weston
fi

cd ${OLD_PWD}
