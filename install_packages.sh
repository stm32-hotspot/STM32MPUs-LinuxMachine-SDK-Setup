#!/bin/bash

#########install from wiki PC pre requisites
##########################################

echo "===================================================================================" 

echo "install developer package bsp components for release OpenSTLinux${OSTL_VERSION}" 

echo "===================================================================================" 


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
cd stm32${INSTALL_MPU}-${OSTL_TAG}/sdk
chmod +x st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_x86_64_SETUP}
./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_x86_64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP1_x86_64

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
cd stm32${INSTALL_MPU}-${OSTL_TAG}/sdk
chmod +x st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_x86_64_SETUP}
./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_x86_64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP2_x86_64
echo "./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_x86_64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP2_x86_64"

fi


if [[(${INSTALL_PACKAGES_MP1_SDK_aarch64} -eq 1)]];
then
echo "install SDK aarch64 STM32MP1  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP1_SDK_aarch64} " 
#SDK
#-----
#Install the SDK (look for wiki article" STM32MP1 Developer Package - SDK " open link to File:Linux.README.HOW TO.txt)

cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_SDK_aarch64} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_SDK_aarch64} ." 

${INSTALL_VM_VERBOSE_ONLY}
tar xvf ${OSTL_PACKAGES_MP1_SDK_aarch64} > ${OUTPUT_FILE}
cd stm32${INSTALL_MPU}-${OSTL_TAG}/sdk
chmod +x st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_aarch64_SETUP}
./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_aarch64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP1_aarch64
echo "./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_aarch64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP1_aarch64"
fi

if [[(${INSTALL_PACKAGES_MP2_SDK_aarch64} -eq 1)]];
then
#SDK
#-----
#Install the SDK (look for wiki article" STM32MP1 Developer Package - SDK " open link to File:Linux.README.HOW TO.txt)
echo "install SDK aarch64 STM32MP2  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP2_SDK_aarch64}" 
cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_SDK_aarch64} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_SDK_aarch64} ."
${INSTALL_VM_VERBOSE_ONLY} 
tar xvf ${OSTL_PACKAGES_MP2_SDK_aarch64} > ${OUTPUT_FILE}
cd stm32${INSTALL_MPU}-${OSTL_TAG}/sdk
chmod +x st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_aarch64_SETUP}
./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_aarch64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP2_aarch64
echo "./st-image-weston-openstlinux-weston-stm32${INSTALL_MPU}.${OSTL_TOOL_CHAIN_aarch64_SETUP} -d $INSTALL_DIR/Developer-Package/SDK_MP2_aarch64"
fi


if [[(${INSTALL_PACKAGES_MP1_DEV_PACKAGE_SRC} -eq 1)]];
then
#Unzip Sources
#-------------
echo "install SDK dev package sources STM32MP1  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP1_DEV_PACKAGE_SRC}" 
cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_DEV_PACKAGE_SRC} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP1_DEV_PACKAGE_SRC} ."
${INSTALL_VM_VERBOSE_ONLY} 
tar xvf ${OSTL_PACKAGES_MP1_DEV_PACKAGE_SRC} > ${OUTPUT_FILE}
fi


if [[(${INSTALL_PACKAGES_MP2_DEV_PACKAGE_SRC} -eq 1)]];
then
#Unzip Sources
#-------------
echo "install SDK dev package sources STM32MP2  for release OpenSTLinux${OSTL_VERSION} ${OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC} " 
cd ${INSTALL_DIR}/Developer-Package
echo "${INSTALL_DIR}/Developer-Package" 
cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC} .
echo "cp ${SHARED_DIR}/${OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC} ."
${INSTALL_VM_VERBOSE_ONLY} 
tar xvf ${OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC} > ${OUTPUT_FILE}
fi

#TF-A
#----
#Install the TF-A (look for wiki article" STM32MP1 Developer Package - TF-A " open link to File:TF-A.README.HOW TO.txt)
if [[(${INSTALL_PACKAGES_T_FA_GIT} -eq 1)]];
then
echo "install tf-a git"

echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}"
echo "rm -rf arm-trusted-firmware"
echo "git clone https://github.com/STMicroelectronics/arm-trusted-firmware.git"
echo "cd arm-trusted-firmware"
echo "git checkout -b WORKING ${TF_A_GIT}"
${INSTALL_VM_VERBOSE_ONLY} 
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}
#install git clone version
rm -rf arm-trusted-firmware
git clone https://github.com/STMicroelectronics/arm-trusted-firmware.git 
cd arm-trusted-firmware
git checkout -b WORKING ${TF_A_GIT}

fi

if [[(${CLEAN_PACKAGES_T_FA_GIT} -eq 1)]];
then
echo "clean tf-a git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}"
#install git clone version
echo "cd arm-trusted-firmware"
echo "make -f ../Makefile.sdk -j8 ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}
cd arm-trusted-firmware
make -f $PWD/../Makefile.sdk -j8 ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware clean

fi

if [[(${BUILD_PACKAGES_T_FA_GIT} -eq 1)]];
then
echo "build tf-a git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}"
#install git clone version
echo "cd arm-trusted-firmware"
echo "make -f ../Makefile.sdk -j8 ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}
cd arm-trusted-firmware
make -f $PWD/../Makefile.sdk -j8 ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware all

fi


if [[(${INSTALL_PACKAGES_T_FA_SRC} -eq 1)]];
then
echo "install tf-a src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}"
#install tar sources version
echo "rm -rf tf-a-stm32mp-${TF_A_DIR}"
echo "tar xvf tf-a-stm32mp-${TF_A_VERSION}.tar.xz"
echo "cd tf-a-stm32mp-${TF_A_DIR}"
echo " for p in \`ls -1 ../*.patch\`; do patch -p1 < \$p; done"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}
rm -rf tf-a-stm32mp-${TF_A_DIR}
tar xvf tf-a-stm32mp-${TF_A_VERSION}.tar.xz > ${OUTPUT_FILE}
cd tf-a-stm32mp-${TF_A_DIR}
for p in `ls -1 ../*.patch`; do patch -p1 < $p; done >> ${OUTPUT_FILE}
fi

if [[(${CLEAN_PACKAGES_T_FA_SRC} -eq 1)]];
then
echo "clean tf-a src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}"
echo "cd tf-a-stm32mp-${TF_A_DIR}"
echo "make -f ../Makefile.sdk -j8 ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}
cd tf-a-stm32mp-${TF_A_DIR}
make -f $PWD/../Makefile.sdk -j8  ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware clean > ${OUTPUT_FILE}

fi

if [[(${BUILD_PACKAGES_T_FA_SRC} -eq 1)]];
then
echo "build tf-a src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}"
echo "cd tf-a-stm32mp-${TF_A_DIR}"
echo "make -f ../Makefile.sdk -j8 ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/tf-a-stm32mp-${TF_A_VERSION}
cd tf-a-stm32mp-${TF_A_DIR}
make -f $PWD/../Makefile.sdk -j8  ${TF_A_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/arm-trusted-firmware all > ${OUTPUT_FILE}

fi



#U-Boot
#------
#Install the U-Boot (look for wiki article" STM32MP1 Developer Package - U-Boot " open link to File:U_Boot.README.HOW TO.txt)
if [[(${INSTALL_PACKAGES_U_BOOT_GIT} -eq 1)]];
then
echo "install u-boot git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}"											  
echo "rm -rf u-boot"
echo "git clone https://github.com/STMicroelectronics/u-boot.git"
echo "cd u-boot"
echo "git checkout -b WORKING ${U_BOOT_GIT}"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}
rm -rf u-boot
#install git clone version
git clone https://github.com/STMicroelectronics/u-boot.git
cd u-boot
git checkout -b WORKING ${U_BOOT_GIT}
fi

if [[(${CLEAN_PACKAGES_U_BOOT_GIT} -eq 1)]];
then
echo "clean u-boot git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}"											  
echo "cd u-boot"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "make -f ../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}
cd u-boot
make -f $PWD/../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot clean
fi

if [[(${BUILD_PACKAGES_U_BOOT_GIT} -eq 1)]];
then
echo "build u-boot git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}"											  
echo "cd u-boot"
echo "make -f ../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}
cd u-boot
make -f $PWD/../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot all

fi


#install tar sources version
if [[(${INSTALL_PACKAGES_U_BOOT_SRC} -eq 1)]];
then
echo "install u-boot src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}"											  
echo "rm -rf u-boot-stm32mp-${U_BOOT_DIR}"
echo "tar -xvf  u-boot-stm32mp-${U_BOOT_VERSION}.tar.xz"
echo "cd u-boot-stm32mp-${U_BOOT_DIR}"
echo " for p in \`ls -1 ../*.patch\`; do patch -p1 < \$p; done"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}
rm -rf u-boot-stm32mp-${U_BOOT_DIR}
tar -xvf  u-boot-stm32mp-${U_BOOT_VERSION}.tar.xz > ${OUTPUT_FILE}
cd u-boot-stm32mp-${U_BOOT_DIR}
for p in `ls -1 ../*.patch`; do patch -p1 < $p; done >> ${OUTPUT_FILE}
fi

if [[(${CLEAN_PACKAGES_U_BOOT_SRC} -eq 1)]];
then
echo "clean u-boot src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}"											  
echo "cd u-boot-stm32mp-${U_BOOT_DIR}"
echo "make -f ../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}
cd u-boot-stm32mp-${U_BOOT_DIR}
make -f $PWD/../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot clean > ${OUTPUT_FILE}
fi

if [[(${BUILD_PACKAGES_U_BOOT_SRC} -eq 1)]];
then
echo "build u-boot src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}"											  
echo "cd u-boot-stm32mp-${U_BOOT_DIR}"
echo "make -f ../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/u-boot-stm32mp-${U_BOOT_VERSION}
cd u-boot-stm32mp-${U_BOOT_DIR}
make -f $PWD/../Makefile.sdk -j8 ${U_BOOT_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/u-boot all > ${OUTPUT_FILE}
fi


#OPTEE
#------
#Install the OPTEE (look for wiki article" STM32MP1 Developer Package - OPTEE " open link to File:OPTEE.README.HOW TO.txt)

if [[(${INSTALL_PACKAGES_OPTEE_GIT} -eq 1)]];
then
echo "install optee git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}"
echo "rm -rf optee_os"
echo "git clone https://github.com/STMicroelectronics/optee_os.git"
echo "cd optee_os"
echo "git checkout -b WORKING ${OPTEE_GIT}"
${INSTALL_VM_VERBOSE_ONLY}
cd  $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}
rm -rf optee_os
git clone https://github.com/STMicroelectronics/optee_os.git
cd optee_os
git checkout -b WORKING ${OPTEE_GIT}
fi

if [[(${CLEAN_PACKAGES_OPTEE_GIT} -eq 1)]];
then
echo "clean optee git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}"
echo "cd optee_os"
echo "source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}"
echo "chmod 755 scripts/bin_to_c.py"
echo "make -f ../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}
cd optee_os
source $SDK_ROOT/${SDK_NAME}/${OSTL_DEV_PACKAGE_ENV_SETUP}
chmod 755 scripts/bin_to_c.py > ${OUTPUT_FILE}
make -f $PWD/../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee clean >> ${OUTPUT_FILE}
fi

if [[(${BUILD_PACKAGES_OPTEE_GIT} -eq 1)]];
then
echo "build optee git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}"
echo "cd optee_os"
echo "chmod 755 scripts/bin_to_c.py"
echo "export FIP_DEPLOYDIR_ROOT=${FIP_ARTIFACT_DIRECTORY}"
echo "make -f ../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}
cd optee_os
chmod 755 scripts/bin_to_c.py > ${OUTPUT_FILE}
make -f $PWD/../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee all >> ${OUTPUT_FILE}
fi



if [[(${INSTALL_PACKAGES_OPTEE_SRC} -eq 1)]];
then
echo "install optee src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}"
echo "rm -rf  optee-os-stm32mp-${OPTEE_DIR}"
echo "tar -xvf  optee-os-stm32mp-${OPTEE_VERSION}.tar.xz"
echo "cd optee-os-stm32mp-${OPTEE_DIR}"
echo "tar xfz ../fonts.tar.gz"
echo "for p in \`ls -1 ../*.patch\`; do patch -p1 < \$p; done"

#see also 
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}
rm -rf  optee-os-stm32mp-${OPTEE_DIR}
tar -xvf  optee-os-stm32mp-${OPTEE_VERSION}.tar.xz > ${OUTPUT_FILE}
#grep "$>" README.HOW_TO.txt
#    $> tar xf optee-os-stm32mp-$OPTEE-VERSION.tar.xz
#    $> cd optee-os-stm32mp-$OPTEE-VERSION
#    $> tar xf ../fonts.tar.gz
#    $> for p in `ls -1 ../*.patch`; do patch -p1 < $p; done
#    $> export FIP_DEPLOYDIR_ROOT=$PWD/../../FIP_artifacts
#    $> make -f $PWD/../Makefile.sdk DEPLOYDIR=$FIP_DEPLOYDIR_ROOT/optee all
${INSTALL_VM_VERBOSE_ONLY}
cd optee-os-stm32mp-${OPTEE_DIR}
tar xfz ../fonts.tar.gz >> ${OUTPUT_FILE}
for p in `ls -1 ../*.patch`; do patch -p1 < $p; done >> ${OUTPUT_FILE}
fi

if [[(${CLEAN_PACKAGES_OPTEE_SRC} -eq 1)]];
then
echo "clean optee src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}"
echo "cd optee-os-stm32mp-${OPTEE_DIR}"
echo "chmod 755 scripts/bin_to_c.py"
echo "make -f ../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}
cd optee-os-stm32mp-${OPTEE_DIR}
chmod 755 scripts/bin_to_c.py > ${OUTPUT_FILE}
make -f $PWD/../Makefile.sdk  -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee clean >> ${OUTPUT_FILE}
fi

if [[(${BUILD_PACKAGES_OPTEE_SRC} -eq 1)]];
then
echo "build optee src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}"
echo "cd optee-os-stm32mp-${OPTEE_DIR}"
echo "chmod 755 scripts/bin_to_c.py"
echo "make -f ../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/optee-os-stm32mp-${OPTEE_VERSION}
cd optee-os-stm32mp-${OPTEE_DIR}
chmod 755 scripts/bin_to_c.py > ${OUTPUT_FILE}
make -f $PWD/../Makefile.sdk -j8 ${OPTEE_CMD_LINE} DEPLOYDIR=${FIP_ARTIFACT_DIRECTORY}/optee all >> ${OUTPUT_FILE}

fi


if [[(${INSTALL_MPU} -eq mp2)]];
then
if [[(${INSTALL_PACKAGES_MP2_EXTERNAL_DT} -eq 1)]];
then
echo "install external dt src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/external-dt-${EXTDT_VERSION}"
echo "rm -rf external-dt-${EXTDT_DIR_NAME}"
echo "tar -xvf  external-dt-${EXTDT_VERSION}.tar.xz"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/external-dt-${EXTDT_VERSION}
rm -rf external-dt-${EXTDT_DIR_NAME}
tar -xvf  external-dt-${EXTDT_VERSION}.tar.xz
fi
fi

if [[(${INSTALL_MPU} -eq mp2)]];
then

if [[(${INSTALL_PACKAGE_MP2_FWDDR} -eq 1)]];
then
echo "install stm32mp-ddr-phy-"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/stm32mp-ddr-phy-${FWDDR_VERSION}"
echo "rm -rf stm32mp-ddr-phy-${FWDDR_DIR_NAME}"
echo "tar -xvf  stm32mp-ddr-phy-${FWDDR_VERSION}.tar.xz"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/$OSTL_DEV_PACKAGE_SRC_DIR/stm32mp-ddr-phy-${FWDDR_VERSION}
rm -rf stm32mp-ddr-phy-${FWDDR_DIR_NAME}
tar -xvf  stm32mp-ddr-phy-${FWDDR_VERSION}.tar.xz
fi
fi


if [[(${INSTALL_MPU} -eq mp2)]];
then
if [[(${INSTALL_PACKAGES_FIP_ARTIFACT_CP} -eq 1)]];
then
cp -a ${SHARED_DIR}/FIP_artifacts_MP2.tar $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/
tar xvf FIP_artifacts_MP2.tar
fi
fi

#LINUX kernel
#-------------

if [[(${INSTALL_PACKAGES_KERNEL_GIT} -eq 1)]];
then
echo "install linux kernel git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "rm -rf linux"
echo "git clone https://github.com/STMicroelectronics/linux.git"
echo "cd linux"
echo "git checkout -b WORKING $LINUX_GIT"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
#see also 
#grep "$>" README.HOW_TO.txt
rm -rf linux
git clone https://github.com/STMicroelectronics/linux.git
cd linux
git checkout -b WORKING $LINUX_GIT
fi

if [[(${CONFIGURE_PACKAGES_KERNEL_GIT} -eq 1)]];
then
echo "configure linux kernel git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux"
echo "make ARCH=${LINUX_CMD_LINE_ARCH} ${LINUX_CMD_LINE_DEFCONFIG}  fragment*.config"
#echo "for f in \`ls -1 ..\/fragment\*.config\`\; do scripts//kconfig//merge_config.sh -m -r .config $f; done"
echo "yes '' | make ARCH=${LINUX_CMD_LINE_ARCH} oldconfig"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux
make ARCH=${LINUX_CMD_LINE_ARCH} ${LINUX_CMD_LINE_DEFCONFIG} fragment*.config
for f in 'ls -1 ../fragment*.config'; do scripts/kconfig/merge_config.sh -m -r -O ${PWD} ${PWD}/.config $f; done
yes '' | make ARCH=${LINUX_CMD_LINE_ARCH} oldconfig
fi

if [[(${CLEAN_PACKAGES_KERNEL_GIT} -eq 1)]];
then
echo "clean linux kernel git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux"
echo "make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux
make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean
fi

if [[(${BUILD_PACKAGES_KERNEL_GIT} -eq 1)]];
then
echo "build linux kernel git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux"
echo "make -j8 ${LINUX_CMD_LINE}""
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux
make -j8 ${LINUX_CMD_LINE}"

fi



if [[(${CLEAN_PACKAGES_KERNEL_MODULES_GIT} -eq 1)]];
then
echo "clean kernel modules git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux"
echo "make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux
make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean

fi

if [[(${BUILD_PACKAGES_KERNEL_MODULES_GIT} -eq 1)]];
then
echo "build kernel modules git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux"
echo "make -j8 ARCH=${LINUX_CMD_LINE_ARCH} modules"
echo "mkdir -p ./install_artifact/"
echo "make  ARCH=${LINUX_CMD_LINE_ARCH} INSTALL_MOD_PATH="./install_artifact" modules_install"
echo "rm ./install_artifact/lib/modules/${LINUX_DIR}/source"
echo "rm ./install_artifact/lib/modules/${LINUX_DIR}/source"
echo "cd ./install_artifact/lib/modules/${LINUX_DIR}/"
echo "find . -name "*.ko" | xargs $STRIP --strip-debug --remove-section=.comment --remove-section=.note --preserve-dates"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux
make -j8 ARCH=${LINUX_CMD_LINE_ARCH} modules
mkdir -p $PWD/install_artifact/
make  ARCH=${LINUX_CMD_LINE_ARCH} INSTALL_MOD_PATH="$PWD/install_artifact" modules_install
rm $PWD/install_artifact/lib/modules/${LINUX_DIR}/build
rm $PWD/install_artifact/lib/modules/${LINUX_DIR}/source
cd $PWD/install_artifact/lib/modules/${LINUX_DIR}/
find . -name "*.ko" | xargs $STRIP --strip-debug --remove-section=.comment --remove-section=.note --preserve-dates
fi


if [[(${INSTALL_PACKAGES_KERNEL_SRC} -eq 1)]];
then
echo "install linux kernel src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "rm -rf linux-$LINUX_DIR"
echo "tar xvf linux-$LINUX_DIR.tar.xz"
echo "cd linux-$LINUX_DIR"
echo " for p in \`ls -1 ../*.patch\`; do patch -p1 < \$p; done"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
rm -rf linux-$LINUX_DIR
tar xvf linux-$LINUX_DIR.tar.xz > ${OUTPUT_FILE}
cd linux-$LINUX_DIR
for p in `ls -1 ../*.patch`; do patch -p1 < $p; done >> ${OUTPUT_FILE}
fi

if [[(${CONFIGURE_PACKAGES_KERNEL_SRC} -eq 1)]];
then
echo "configure linux kernel src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux-$LINUX_DIR"
echo "make ARCH=${LINUX_CMD_LINE_ARCH} ${LINUX_CMD_LINE_DEFCONFIG}  fragment*.config"
echo "for f in \'ls -1 ../fragment*.config\'; do scripts/kconfig/merge_config.sh -m -r .config $f; done"
echo "yes '' | make ARCH=${LINUX_CMD_LINE_ARCH} oldconfig"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux-$LINUX_DIR
make ARCH=${LINUX_CMD_LINE_ARCH} ${LINUX_CMD_LINE_DEFCONFIG}  fragment*.config > ${OUTPUT_FILE}
for f in 'ls -1 ../fragment*.config'; do scripts/kconfig/merge_config.sh -m -r .config $f; done >> ${OUTPUT_FILE}
yes '' | make ARCH=${LINUX_CMD_LINE_ARCH} oldconfig >> ${OUTPUT_FILE}
fi

if [[(${CLEAN_PACKAGES_KERNEL_SRC} -eq 1)]];
then
echo "clean linux kernel src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux-$LINUX_DIR"
echo "make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux-$LINUX_DIR
make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean > ${OUTPUT_FILE}
fi

if [[(${BUILD_PACKAGES_KERNEL_SRC} -eq 1)]];
then
echo "build linux kernel src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux-$LINUX_DIR"
echo "make -j8 ${LINUX_CMD_LINE}"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux-$LINUX_DIR
make -j8 ${LINUX_CMD_LINE} > ${OUTPUT_FILE}
fi


if [[(${CLEAN_PACKAGES_KERNEL_MODULES_SRC} -eq 1)]];
then
echo "clean kernel modules src "
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux-$LINUX_DIR"
echo "make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux-$LINUX_DIR
make -j8 ARCH=${LINUX_CMD_LINE_ARCH} clean > ${OUTPUT_FILE}
fi

if [[(${BUILD_PACKAGES_KERNEL_MODULES_SRC} -eq 1)]];
then
echo "build kernel modules src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/"
echo "cd linux-$LINUX_DIR"
echo "make -j8 ARCH=${LINUX_CMD_LINE_ARCH} modules" > ${OUTPUT_FILE}
echo "mkdir -p ./install_artifact/"
echo "make  ARCH=${LINUX_CMD_LINE_ARCH} INSTALL_MOD_PATH="./install_artifact" modules_install"
echo "rm ./install_artifact/lib/modules/${LINUX_DIR}/build"
echo "rm ./install_artifact/lib/modules/${LINUX_DIR}/source"
echo "cd ./install_artifact/lib/modules/${LINUX_DIR}/"
echo "find . -name "*.ko" | xargs $STRIP --strip-debug --remove-section=.comment --remove-section=.note --preserve-dates"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/linux-stm32mp-$LINUX_VERSION/
cd linux-$LINUX_DIR
make -j8 ARCH=${LINUX_CMD_LINE_ARCH} modules
mkdir -p $PWD/install_artifact/
make  ARCH=${LINUX_CMD_LINE_ARCH} INSTALL_MOD_PATH="$PWD/install_artifact" modules_install >> ${OUTPUT_FILE}
rm $PWD/install_artifact/lib/modules/${LINUX_DIR}/build
rm $PWD/install_artifact/lib/modules/${LINUX_DIR}/source
cd $PWD/install_artifact/lib/modules/${LINUX_DIR}/
find . -name "*.ko" | xargs $STRIP --strip-debug --remove-section=.comment --remove-section=.note --preserve-dates
fi


#GCNANO
#------
#
if [[(${INSTALL_PACKAGES_GCNANO_GIT} -eq 1)]];
then
echo "install gcnano git"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}"
echo "rm -rf gcnano-binaries"
echo "git clone https://github.com/STMicroelectronics/gcnano-binaries.git"
echo "cd gcnano-binaries"
echo "git checkout -b WORKING ${GCNANO_GIT}"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}
rm -rf gcnano-binaries
git clone https://github.com/STMicroelectronics/gcnano-binaries.git
cd gcnano-binaries
git checkout -b WORKING ${GCNANO_GIT}
fi

if [[(${CLEAN_PACKAGES_GCNANO_GIT} -eq 1)]];
then
echo "clean gcnano git"
GCNANO_DIR=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}/gcnano-binaries
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}"
echo "cd gcnano-binaries"
echo "export KERNEL_BUILDDIR=../../linux-stm32mp-$LINUX_VERSION/build"
echo "make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${GCNANO_DIR}" AQROOT="${GCNANO_DIR}" -C ${KERNEL_BUILDDIR} clean"
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}
${INSTALL_VM_VERBOSE_ONLY}
cd gcnano-binaries
export KERNEL_BUILDDIR=$PWD/../../linux-stm32mp-$LINUX_VERSION/build
make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${PWD}" AQROOT="${PWD}" -C ${KERNEL_BUILDDIR} clean
fi

if [[(${BUILD_PACKAGES_GCNANO_GIT} -eq 1)]];
then
echo "build gcnano git"
GCNANO_DIR=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}/gcnano-binaries

echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}"
echo "cd gcnano-binaries"
echo "export KERNEL_BUILDDIR=../../linux-stm32mp-$LINUX_VERSION/build"
echo "make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${GCNANO_DIR}" AQROOT="${GCNANO_DIR}" -C ${KERNEL_BUILDDIR} all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}
cd gcnano-binaries
export KERNEL_BUILDDIR=$PWD/../../linux-stm32mp-$LINUX_VERSION/build
make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${PWD}" AQROOT="${PWD}" -C ${KERNEL_BUILDDIR} all
fi



if [[(${INSTALL_PACKAGES_GCNANO_SRC} -eq 1)]];
then
echo "install gcnano src"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}"
echo "rm -rf  gcnano-driver-stm32mp-${GCNANO_DIR}"
echo "tar -xvf  gcnano-driver-stm32mp-${GCNANO_VERSION}.tar.xz"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}
rm -rf  gcnano-driver-stm32mp-${GCNANO_DIR}
tar -xvf  gcnano-driver-stm32mp-${GCNANO_VERSION}.tar.xz > ${OUTPUT_FILE}
#see also 
#grep "$>" README.HOW_TO.txt


fi

if [[(${CLEAN_PACKAGES_GCNANO_SRC} -eq 1)]];
then
echo "clean gcnano src"
GCNANO_DIR=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}/gcnano-driver-stm32mp-${GCNANO_DIR}

echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}"
echo "cd gcnano-driver-stm32mp-${GCNANO_DIR}"
echo "export KERNEL_BUILDDIR=../../linux-stm32mp-$LINUX_VERSION/build"
echo "make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${GCNANO_DIR}" AQROOT="${GCNANO_DIR}" -C ${KERNEL_BUILDDIR} clean"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}
cd gcnano-driver-stm32mp-${GCNANO_DIR}
export KERNEL_BUILDDIR=$PWD/../../linux-stm32mp-$LINUX_VERSION/build
make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${PWD}" AQROOT="${PWD}" -C ${KERNEL_BUILDDIR} clean > ${OUTPUT_FILE}
fi

if [[(${BUILD_PACKAGES_GCNANO_SRC} -eq 1)]];
then
echo "build gcnano src"
GCNANO_DIR=$INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}/gcnano-driver-stm32mp-${GCNANO_DIR}
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}"
echo "cd gcnano-driver-stm32mp-${GCNANO_DIR}"
echo "export KERNEL_BUILDDIR=../../linux-stm32mp-$LINUX_VERSION/build"
echo "make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${GCNANO_DIR}" AQROOT="${GCNANO_DIR}" -C ${KERNEL_BUILDDIR} all"
${INSTALL_VM_VERBOSE_ONLY}
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/gcnano-driver-stm32mp-${GCNANO_VERSION}
cd gcnano-driver-stm32mp-${GCNANO_DIR}
export KERNEL_BUILDDIR=$PWD/../../linux-stm32mp-$LINUX_VERSION/build
make  ${GCNANO_CMD_LINE} DEBUG=0 O="${KERNEL_BUILDDIR}" M="${PWD}" AQROOT="${PWD}" -C ${KERNEL_BUILDDIR} all > ${OUTPUT_FILE}
fi

#MP2 external DT
#------
#
if [[(${INSTALL_PACKAGES_MP2_EXTERNAL_DT} -eq 1)]];
then
echo "install external dt"
echo "cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/external-dt-${EXTDT_VERSION}"
cd $INSTALL_DIR/Developer-Package/stm32${INSTALL_MPU}-$OSTL_TAG/sources/${OSTL_DEV_PACKAGE_SRC_DIR}/external-dt-${EXTDT_VERSION}
echo "rm -rf  external-dt-${EXTDT_DIR_NAME}"
echo "tar -xvf  external-dt-${EXTDT_VERSION}.tar.xz "
${INSTALL_VM_VERBOSE_ONLY}
rm -rf  external-dt-${EXTDT_DIR_NAME}
tar -xvf  external-dt-${EXTDT_VERSION}.tar.xz 
#see also 
#grep "$>" README.HOW_TO.txt

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
echo "repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-mickledore-mpu-v24.06.26"
echo "repo sync"
echo "DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh"
echo "bitbake --runall=fetch st-image-weston"
echo "bitbake -k st-image-weston"
${INSTALL_VM_VERBOSE_ONLY}
repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-mickledore-mpu-v24.06.26
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
echo "repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-mickledore-mpu-v24.06.26"
echo "repo sync"
echo "DISTRO=openstlinux-weston MACHINE=stm32mp2 source layers/meta-st/scripts/envsetup.sh"
echo "bitbake --runall=fetch st-image-weston"
echo "bitbake -k st-image-weston"
${INSTALL_VM_VERBOSE_ONLY}
repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.1-yocto-mickledore-mpu-v24.06.26
repo sync
DISTRO=openstlinux-weston MACHINE=stm32mp2 source layers/meta-st/scripts/envsetup.sh
bitbake --runall=fetch st-image-weston
bitbake -k st-image-weston
fi

