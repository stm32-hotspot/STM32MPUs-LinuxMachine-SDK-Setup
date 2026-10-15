#!/bin/bash

echo "===================================================================================" 

echo "install tools for release OpenSTLinux${OSTL_VERSION}" 

echo "===================================================================================" 

OLD_PWD=${PWD}


#install directories for tools
if [[(${INSTALL_TOOL_DIR} -eq 1)]];
then

[ -d ${HOME}/STM32Cube/ ] && echo "${HOME}/STM32Cube/ already existe" || mkdir ${HOME}/STM32Cube/ ; sudo chmod -R 777 ${HOME}/STM32Cube/
[ -d ${HOME}/STM32Cube/Repository/ ] && echo "${HOME}/STM32Cube/Repository already existe" || mkdir  ${HOME}/STM32Cube/Repository/

[ -d ${INSTALL_TOOL_DIR_NAME} ] && echo "${INSTALL_TOOL_DIR_NAME} already existe" \
|| mkdir ${INSTALL_TOOL_DIR_NAME}; sudo chmod -R 777 ${INSTALL_TOOL_DIR_NAME}/

[ -d ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE ] && echo "${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE already existe" \
|| mkdir ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE

[ -d ${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer ] && echo "${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer already existe" \
|| mkdir ${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer

[ -d ${INSTALL_TOOL_DIR_NAME}/STM32CubeMx ] && echo "${INSTALL_TOOL_DIR_NAME}/STM32CubeMx already existe" \
|| mkdir ${INSTALL_TOOL_DIR_NAME}/STM32CubeMx

fi



#install OPTEE TA examples
if [[(${INSTALL_TA_EXAMPLES} -eq 1)]];
then
#TA examples (NOT tested)
#-----------
#https://optee.readthedocs.io/en/latest/building/trusted_applications.html
#ST does not currently deliver any TA
#but can run examples from
#https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html

cd $INSTALL_DIR/Developer-Package/stm32mp1-$OSTL_TAG/sources/
rm -rf ta_examples
mkdir ta_examples
cd ta_examples
git clone https://github.com/linaro-swg/optee_examples.git
fi

if [[(${BUILD_TA_EXAMPLES} -eq 1)]];
then
cd $INSTALL_DIR/Developer-Package/stm32mp1-$OSTL_TAG/sources/
cd ta_examples
cd optee_examples
source $SDK_ROOT/SDK/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi
export TA_DEV_KIT_DIR=$INSTALL_DIR/Developer-Package/stm32mp1-$OSTL_TAG/sources/arm-ostl-linux-gnueabi/optee-os-stm32mp-$OPTEE_VERSION/build/$BOARD/export-ta_arm32/
export TA_CROSS_COMPILE=$CROSS_COMPILE
export TEEC_EXPORT=$INSTALL_DIR/Developer-Package/stm32mp1-$OSTL_TAG/sources/arm-ostl-linux-gnueabi/optee-os-stm32mp-$OPTEE_VERSION/build/$BOARD/export-ta_arm32/host_include/
cd hello_world
make PLATFORM=stm32mp1 CFG_EMBED_DTB_SOURCE_FILE=$BOARD CFG_TEE_CORE_LOG_LEVEL=2 LIBGCC_LOCATE_CFLAGS=--sysroot=${SDKTARGETSYSROOT}
cd ../aes/
make PLATFORM=stm32mp1 CFG_EMBED_DTB_SOURCE_FILE=$BOARD CFG_TEE_CORE_LOG_LEVEL=2 LIBGCC_LOCATE_CFLAGS=--sysroot=${SDKTARGETSYSROOT}

#How to test TA example
#
#boot board in u-boot
#>ums 0 mmc 0
#from host terminal copy host binary + ta binary on board
#
#sudo cp ./hello_world/host/optee_example_hello_world /media/$USER/rootfs/usr/bin/
#sudo cp ./hello_world/ta/8aaaf200-2450-11e4-abe2-0002a5d5c51b.ta  /media/$USER/rootfs/lib/optee_armtz/
#sudo cp ./aes/host/optee_example_aes /media/$USER/rootfs/usr/bin/
#sudo cp ./aes/ta/5dbac793-f574-4871-8ad3-04331ec17f24.ta /media/$USER/rootfs/lib/optee_armtz/

#reboot the board
#root@stm32mp1:~# optee_example_hello_world                                      
#D/TA:  TA_CreateEntryPoint:39 has been called                                   
#D/TA:  TA_OpenSessionEntryPoint:68 has been called                              
#I/TA: Hello World!                                                              
#Invoking TA to increment 42                                                     
#D/TA:  inc_value:105 has been called                                            
#I/TA: Got value: 42 from NW                                                     
#I/TA: Increase value to: 43                                                     
#TA incremented vaI/TA: Goodbye!                                                 
#lue to 43                                                                       
#D/TA:  TA_DestroyEntryPoint:50 has been called                                  
#
#root@stm32mp1:~# optee_example_aes                                              
#Prepare session with the TA                                                     
#D/TA:  TA_OpenSessionEntryPoint:394 Session 0x400452c8: newly allocated         
#Prepare encode operation                                                        
#D/TA:  alloc_resources:124 Session 0x400452c8: get ciphering resources          
#Load key in TA                                                                  
#D/TA:  set_aes_key:240 Session 0x400452c8: load key material                    
#Reset ciphering operation in TA (provides the initial vecD/TAtor):  reset_aes_ir
#                                                                                
#Encode buffer from TA                                                           
#D/TA:  cipher_buffer:340 Session 0x400452c8: cipher buffer                      
#Prepare decode operation                                                        
#D/TA:  alloc_resources:124 Session 0x400452c8: get ciphering resources          
#Load key in TA                                                                  
#D/TA:  set_aes_key:240 Session 0x400452c8: load key material                    
#Reset ciphering operation in TA (provides the initial vecDto/r)                 
#TA:  reset_aes_iv:308 Session 0x400452c8: reset initial vector                  
#Decode buffer from TA                                                           
#D/TA:  cipher_buffer:340 Session 0x400452c8: cipher buffer                      
#Clear text and decoded text match                                               
#D/TA:  TA_CloseSessionEntryPoint:404 Session 0x400452c8: release session        
#
#TESTED OK
fi

#install gdb scripts
if [[(${INSTALL_GDB_SCRIPTS} -eq 1)]];
then
#How to debug with gdbscripts
#---------------------------

#from wiki article
#https://wiki.st.com/stm32mpu/wiki/GDB

cp -a gdb_script*/* ${HOME}/gdbscripts
#to get commands read following files
#gdbscripts-build_trusted/cmd.txt (not tested) 
#gdbscripts-build_optee/cmd.txt (not tested)
#gdb_during_cubeprogrammer/cmd.txt (not tested) 

fi

#install STM32 CubeMP1
if [[(${INSTALL_CUBEMP15} -eq 1)]];
then
echo "cp ${SHARED_DIR}/${CUBEMP15_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/"
cp ${SHARED_DIR}/${CUBEMP15_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/
echo "cd ${HOME}/STM32Cube/Repository/"
cd ${HOME}/STM32Cube/Repository/
if [[(-d  STM32Cube_FW_MP15_V${CUBEMP15_VERSION})]];
then 
#archive previous package
package_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
echo "tar cvf STM32Cube_FW_MP1_V${CUBEMP15_VERSION}${package_install_date}.tar STM32Cube_FW_MP1_V${CUBEMP15_VERSION} "
tar cvf STM32Cube_FW_MP1_V${CUBEMP15_VERSION}${package_install_date}.tar STM32Cube_FW_MP1_V${CUBEMP15_VERSION} 
echo "rm-f  STM32Cube_FW_MP1_V${CUBEMP15_VERSION}"
rm -rf STM32Cube_FW_MP1_V${CUBEMP15_VERSION}
fi

echo "unzip ${CUBEMP15_PACKAGE_NAME}"
unzip ${CUBEMP15_PACKAGE_NAME}
fi

#install STM32 CubeMP13
if [[(${INSTALL_CUBEMP13} -eq 1)]];
then
echo "cp ${SHARED_DIR}/${CUBEMP13_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/"
cp ${SHARED_DIR}/${CUBEMP13_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/
echo "cd ${HOME}/STM32Cube/Repository/"
cd ${HOME}/STM32Cube/Repository/

#archive previous package
if [[ (-d  STM32Cube_FW_MP13_V${CUBEMP13_VERSION})]];
then 
package_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
echo "tar cvf STM32Cube_FW_MP1_V${CUBEMP13_VERSION}${package_install_date}.tar STM32Cube_FW_MP13_V${CUBEMP13_VERSION} }"
tar cvf STM32Cube_FW_MP13_V${CUBEMP13_VERSION}${package_install_date}.tar STM32Cube_FW_MP13_V${CUBEMP13_VERSION} 
echo "rm-f  STM32Cube_FW_MP13_V${CUBEMP13_VERSION}"
rm -rf STM32Cube_FW_MP13_V${CUBEMP13_VERSION}
fi

echo "unzip ${CUBEMP13_PACKAGE_NAME}"
unzip ${CUBEMP13_PACKAGE_NAME}
fi

#install STM32 CubeMP2
if [[(${INSTALL_CUBEMP2} -eq 1)]];
then
echo "cp ${SHARED_DIR}/${CUBEMP2_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/"
cp ${SHARED_DIR}/${CUBEMP2_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/
echo "cd ${HOME}/STM32Cube/Repository/"
cd ${HOME}/STM32Cube/Repository/

if [[ (-d STM32Cube_FW_MP2_V${CUBEMP2_VERSION})]];
then 
#archive previous package
package_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
echo "tar cvf STM32Cube_FW_MP2_V${CUBEMP2_VERSION}${package_install_date}.tar STM32Cube_FW_MP2_V${CUBEMP2_VERSION}"
tar cvf STM32Cube_FW_MP2_V${CUBEMP2_VERSION}${package_install_date}.tar STM32Cube_FW_MP2_V${CUBEMP2_VERSION} 
echo "rm-f  STM32Cube_FW_MP2_V${CUBEMP2_VERSION}"
rm -rf STM32Cube_FW_MP2_V${CUBEMP2_VERSION}
fi

echo "unzip ${CUBEMP2_PACKAGE_NAME}"
unzip ${CUBEMP2_PACKAGE_NAME}

echo "mv  STM32Cube_FW_MP2_V${CUBEMP2_VERSION_BASE}  STM32Cube_FW_MP2_V${CUBEMP2_VERSION}"
mv  STM32Cube_FW_MP2_V${CUBEMP2_VERSION_BASE}  STM32Cube_FW_MP2_V${CUBEMP2_VERSION}

fi

#install STM32 CubeMP2 bare metal
if [[(${INSTALL_CUBEMP2_BM} -eq 1)]];
then
echo "cp ${SHARED_DIR}/${CUBEMP2_BM_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/"
cp ${SHARED_DIR}/${CUBEMP2_BM_PACKAGE_NAME} ${HOME}/STM32Cube/Repository/
echo "cd ${HOME}/STM32Cube/Repository/"
cd ${HOME}/STM32Cube/Repository/

if [[ (-d STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION})]];
then 
#archive previous package
package_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
echo "tar cvf STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}${package_install_date}.tar STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}"
tar cvf STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}${package_install_date}.tar STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION} 
echo "rm-f  STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}"
rm -rf STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}
fi

echo "unzip ${CUBEMP2_BM_PACKAGE_NAME}"
unzip ${CUBEMP2_BM_PACKAGE_NAME}
mv STM32CubeMP2-${CUBEMP2_BM_VERSION} STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}
fi


#install tf-m in STM32 CubeMP2 or in STM32 CubeM2 Bare metal
if [[(${INSTALL_CUBEMP2_TFM} -eq 1)]];
then
echo "cd ${CUBEMP2_TFM_DIRECTORY_NAME}"
cd ${CUBEMP2_TFM_DIRECTORY_NAME}

#archive previous package
if [[(-d trusted-firmware-m)]];
then
tfm_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
echo "tar cvf trusted-firmware-m_$tfm_install_date.tar trusted-firmware-m "
tar cvf trusted-firmware-m_$tfm_install_date.tar trusted-firmware-m 
echo "rm -rf trusted-firmware-m"
rm -rf trusted-firmware-m
fi

echo "git clone https://github.com/STMicroelectronics/trusted-firmware-m.git"
git clone https://github.com/STMicroelectronics/trusted-firmware-m.git
echo "cd trusted-firmware-m"
cd trusted-firmware-m
echo "git checkout ${CUBEMP2_TFM_VERSION}"
git checkout ${CUBEMP2_TFM_VERSION}

fi

#install tf-m in STM32 CubeMP2 or in STM32 CubeM2 Bare metal
if [[(${INSTALL_CUBEMP2_TFM_EXT_DT} -eq 1)]];
then
echo "cd ${CUBEMP2_TFM_EXT_DT_DIRECTORY_NAME}"
cd ${CUBEMP2_TFM_EXT_DT_DIRECTORY_NAME}

#archive previous package
if [[(-d dt-stm32mp)]];
then
tfm_ext_dt_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
echo "tar cvf dt-stm32mp_$tfm_ext_dt_install_date.tar dt-stm32mp "
tar cvf dt-stm32mp_$tfm_ext_dt_install_date.tar dt-stm32mp
echo "rm -rf trusted-firmware-m"
rm -rf dt-stm32mp
fi

echo "git clone https://github.com/STMicroelectronics/trusted-firmware-m.git"
git clone https://github.com/STMicroelectronics/dt-stm32mp
echo "cd dt-stm32mp"
cd dt-stm32mp
echo "git checkout ${CUBEMP2_EXT_DT_VERSION}"
git checkout ${CUBEMP2_EXT_DT_VERSION}

fi

#install STM32 DDR Fw Utility
if [[(${INSTALL_STM32DDRFW_UTIL} -eq 1)]];
then
cd ${STM32DDRFW_UTIL_DIR_NAME}

#archive previous package
package_install_date=$(date '+%d_%m_%Y-%H_%M_%S');
if [[(-d  ${STM32DDRFW_UTIL_DIR_NAME}/STM32DDRFW-UTIL )]];
then
echo "tar cvf ${STM32DDRFW_UTIL_DIR_NAME}/STM32DDRFW-UTIL_${package_install_date}.tar ${STM32DDRFW_UTIL_DIR_NAME}/STM32DDRFW-UTIL "
tar cvf ${STM32DDRFW_UTIL_DIR_NAME}/STM32DDRFW-UTIL_${package_install_date}.tar ${STM32DDRFW_UTIL_DIR_NAME}/STM32DDRFW-UTIL 
echo "rm -rf STM32DDRFW-UTIL "
rm -rf STM32DDRFW-UTIL 
fi

git clone https://github.com/STMicroelectronics/STM32DDRFW-UTIL
fi

#install STM32Cubeprogrammer
#(see UM2237 from https://wiki.st.com/stm32mpu/wiki/STM32MP15_resources)
#	installed in ~/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin
if [[(${INSTALL_TOOLS_CUBEPROG} -eq 1)]];
then
echo "cd ${SHARED_DIR}"
echo "cp ${CUBEPROG_PACKAGE_NAME} ${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer"
echo "cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer"
echo "unzip ${CUBEPROG_PACKAGE_NAME}"
echo "sudo chmod 777 ${CUBEPROG_PACKAGE_INSTALL_SCRIPT}"
echo "sudo apt-get install libusb-1.0-0"
echo "cd ${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules"
echo "sudo cp *.* /etc/udev/rules.d/"
echo ""echo export PATH=\"${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH\"">> ${HOME}/.bashrc"
${INSTALL_VM_VERBOSE_ONLY}
cd ${SHARED_DIR}
cp ${CUBEPROG_PACKAGE_NAME} ${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer
cd  ${INSTALL_TOOL_DIR_NAME}/STM32CubeProgrammer
unzip ${CUBEPROG_PACKAGE_NAME}
sudo chmod 777 ${CUBEPROG_PACKAGE_INSTALL_SCRIPT}
./${CUBEPROG_PACKAGE_INSTALL_SCRIPT}
sudo apt-get install libusb-1.0-0
cd ${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules
sudo cp *.* /etc/udev/rules.d/
echo " export PATH=\"${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH\"" >> ${HOME}/.bashrc

#to launch STM32CubeProgrammer UI in command line
#	cd ~/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin
#	./STM32CubeProgrammer
fi

#install STM32CubeMx
if [[(${INSTALL_TOOLS_CUBEMX} -eq 1)]];
then
echo "cd ${SHARED_DIR}"
echo "cp ${CUBEMX_PACKAGE_NAME} ${INSTALL_TOOL_DIR_NAME}/STM32CubeMx"
echo "cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeMx"
echo "unzip ${CUBEMX_PACKAGE_NAME}"
echo "sudo chmod +x ./${CUBEMX_PACKAGE_INSTALL_SCRIPT}"
echo "./${CUBEMX_PACKAGE_INSTALL_SCRIPT}"
${INSTALL_VM_VERBOSE_ONLY}
cd ${SHARED_DIR}
cp ${CUBEMX_PACKAGE_NAME} ${INSTALL_TOOL_DIR_NAME}/STM32CubeMx
cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeMx
unzip ${CUBEMX_PACKAGE_NAME} 
sudo chmod +x ./${CUBEMX_PACKAGE_INSTALL_SCRIPT}	
./${CUBEMX_PACKAGE_INSTALL_SCRIPT}
#to start CubeMx:
#${HOME}/STM32CubeMX/STM32CubeMX 
fi

#install STM32CubeIDE
	
if [[(${INSTALL_TOOLS_CUBEIDE} -eq 1)]];
then
echo "cd ${SHARED_DIR}"
echo "cp ${CUBEIDE_PACKAGE_NAME} ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE"
echo "cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE"
echo "unzip ${CUBEIDE_PACKAGE_NAME}"
echo "cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE"
echo "sudo chmod +x ${CUBEIDE_PACKAGE_INSTALL_SCRIPT}"
echo "sudo ./${CUBEIDE_PACKAGE_INSTALL_SCRIPT}"
${INSTALL_VM_VERBOSE_ONLY}
cd ${SHARED_DIR}
cp ${CUBEIDE_PACKAGE_NAME} ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE
cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE
unzip ${CUBEIDE_PACKAGE_NAME} 
cd ${INSTALL_TOOL_DIR_NAME}/STM32CubeIDE
sudo chmod +x ${CUBEIDE_PACKAGE_INSTALL_SCRIPT}
sudo ./${CUBEIDE_PACKAGE_INSTALL_SCRIPT}
fi

#to start CubeIDE:
#/opt/st/stm32cubeide_1.11.0/stm32cubeide&
#	Get all info (Release note, User man ) in "infromation center" tab under CubeIDE
#	In network connection settings
#	Select "manual"  in Active Provide tick box
# 	add manual proxy <proxy> port= 8080    
#	add board address (192.168.7.1) in byPass Proxy window.
#	in Firmware Updater settings, click on "check Connection" box => see green tick sign

#install desktop icons
if [[(${INSTALL_TOOLS_DESKTOP_ICONS} -eq 1)]];
then

sudo cp ${SHARED_DIR}/*.png ${HOME}/Downloads/

echo "[Desktop Entry]" > ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Name=STM32CubeMx" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Comment=STMicroelectronics STM32CubeMx" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "GenericName=STM32CubeMX" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Exec=${HOME}/STM32CubeMX/STM32CubeMX %F" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Icon=${CUBEMX_Icon}" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Path=${HOME}/STM32CubeMX" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Terminal=false" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "StartupNotify=true" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Type=Application" >> ${HOME}/Desktop/st-stm32cubeMx.desktop
echo "Categories=Development" >> ${HOME}/Desktop/st-stm32cubeMx.desktop

#For adding to favorites applications
sudo cp /$HOME/Desktop/*.desktop /usr/share/applications/
sudo cp /usr/share/applications/*stm32cubeide*.desktop /$HOME/Desktop/
sudo chmod +x /usr/share/applications/ST*.desktop
sudo chmod +x /usr/share/applications/st-*.desktop
sudo chmod +x /$HOME/Desktop/*.desktop

#!!!!!For all .desktop icones on Desktop, rightclick, 
#and select "allow launching"
#from application dashboard, select application 
#and do right click "add to favorites"
fi

#For VMwaretool (updated)
#In click on menu Player/Mangage/VMwareTools installation (opens a virtual CD drive)
#cp /media/osboxes/VMware\ Tools/VMwareTools-10.3.22-15902021.tar.gz /home/osboxes/Desktop
#tar xvf /home/osboxes/Desktop/VMwareTools-10.3.22-15902021.tar.gz
#cd /home/osboxes/Desktop/vmware-tools-distrib
#sudo ./vmware-install.pl 
#reboot
#sudo apt-get install open-vm-tools
#reboot

cd ${OLD_PWD}
