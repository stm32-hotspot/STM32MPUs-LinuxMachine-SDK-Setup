#!/bin/bash

echo "===================================================================================" 

echo "install tools for release OpenSTLinux${OSTL_VERSION}" 

echo "===================================================================================" 

#install directories for tools
if [[(${INSTALL_TOOL_DIR} -eq 1)]];
then
sudo mkdir ${HOME}/STM32Cube/
sudo mkdir ${HOME}/STM32Cube/Repository
sudo mkdir ${HOME}/STM32MPU-Tools
sudo mkdir ${HOME}/STM32MPU-Tools/STM32CubeIDE
sudo mkdir ${HOME}/STM32MPU-Tools/STM32CubeProgrammer
sudo mkdir ${HOME}/STM32MPU-Tools/STM32CubeMx
sudo chmod -R 777 ${HOME}/STM32Cube/
sudo chmod -R 777 ${HOME}/STM32MPU-Tools/
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

cp -a gdb_script*/* /home/osboxes/gdbscripts
#to get commands read following files
#gdbscripts-build_trusted/cmd.txt (not tested) 
#gdbscripts-build_optee/cmd.txt (not tested)
#gdb_during_cubeprogrammer/cmd.txt (not tested) 

fi

#install STM32 CubeMP1
if [[(${INSTALL_CUBEMP1} -eq 1)]];
then
unzip ${CUBEMP1_PACKAGE_NAME} ${HOME}/STM32Cube/Repository
fi

#install STM32 CubeMP13
if [[(${INSTALL_CUBEMP13} -eq 1)]];
then
unzip ${CUBEMP13_PACKAGE_NAME} ${HOME}/STM32Cube/Repository
fi

#install STM32 DDR Fw Utility
if [[(${INSTALL_STM32DDRFW_UTIL} -eq 1)]];
then
cd ${HOME}/STM32MPU-Tools
git clone https://github.com/STMicroelectronics/STM32DDRFW-UTIL
fi

#install STM32Cubeprogrammer
#(see UM2237 from https://wiki.st.com/stm32mpu/wiki/STM32MP15_resources)
#	installed in ~/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin
if [[(${INSTALL_TOOLS_CUBEPROG} -eq 1)]];
then
echo "cp ${CUBEPROG_PACKAGE_NAME} ${HOME}/STM32MPU-Tools/STM32CubeProgrammer"
echo "cd ${HOME}/STM32MPU-Tools/STM32CubeProgrammer"
echo "unzip ${CUBEPROG_PACKAGE_NAME}"
echo "sudo chmod 777 ${CUBEPROG_PACKAGE_INSTALL_SCRIPT}"
echo "sudo apt-get install libusb-1.0-0"
echo "cd ${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules"
echo "sudo cp *.* /etc/udev/rules.d/"
echo "echo \"export PATH=/home/osboxes/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH\" >> /home/osboxes/.bashrc"
${INSTALL_VM_VERBOSE_ONLY}
cp ${CUBEPROG_PACKAGE_NAME} ${HOME}/STM32MPU-Tools/STM32CubeProgrammer
cd  ${HOME}/STM32MPU-Tools/STM32CubeProgrammer
unzip ${CUBEPROG_PACKAGE_NAME}
sudo chmod 777 ${CUBEPROG_PACKAGE_INSTALL_SCRIPT}
./${CUBEPROG_PACKAGE_INSTALL_SCRIPT}
sudo apt-get install libusb-1.0-0
cd ${HOME}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules
sudo cp *.* /etc/udev/rules.d/
echo "export PATH=/home/osboxes/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH" >> /home/osboxes/.bashrc
#to launch STM32CubeProgrammer UI in command line
#	cd ~/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin
#	./STM32CubeProgrammer
fi

#install STM32CubeMx
if [[(${INSTALL_TOOLS_CUBEMX} -eq 1)]];
then
echo "cp ${CUBEMX_PACKAGE_NAME} ${HOME}/STM32MPU-Tools/STM32CubeMx"
echo "cd ${HOME}/STM32MPU-Tools/STM32CubeMx"
echo "unzip ${CUBEMX_PACKAGE_NAME}"
echo "sudo chmod +x ./${CUBEMX_PACKAGE_INSTALL_SCRIPT}"
echo "./${CUBEMX_PACKAGE_INSTALL_SCRIPT}"
${INSTALL_VM_VERBOSE_ONLY}
cp ${CUBEMX_PACKAGE_NAME} ${HOME}/STM32MPU-Tools/STM32CubeMx
cd ${HOME}/STM32MPU-Tools/STM32CubeMx
unzip ${CUBEMX_PACKAGE_NAME} 
sudo chmod +x ./${CUBEMX_PACKAGE_INSTALL_SCRIPT}	
./${CUBEMX_PACKAGE_INSTALL_SCRIPT}
#to start CubeMx:
#/home/osboxes/STM32CubeMX/STM32CubeMX 
fi

#install STM32CubeIDE
	
if [[(${INSTALL_TOOLS_CUBEIDE} -eq 1)]];
then
echo "cp ${CUBEIDE_PACKAGE_NAME} ${HOME}/STM32MPU-Tools/STM32CubeIDE"
echo "cd ${HOME}/STM32MPU-Tools/STM32CubeIDE"
echo "unzip ${CUBEIDE_PACKAGE_NAME}"
echo "cd ${HOME}/STM32MPU-Tools/STM32CubeIDE"
echo "sudo chmod +x ${CUBEIDE_PACKAGE_INSTALL_SCRIPT}"
echo "sudo ./${CUBEIDE_PACKAGE_INSTALL_SCRIPT}"
${INSTALL_VM_VERBOSE_ONLY}
cp ${CUBEIDE_PACKAGE_NAME} ${HOME}/STM32MPU-Tools/STM32CubeIDE
cd ${HOME}/STM32MPU-Tools/STM32CubeIDE
unzip ${CUBEIDE_PACKAGE_NAME} 
cd ${HOME}/STM32MPU-Tools/STM32CubeIDE
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

sudo cp ${SHARED_DIR}/*.png /home/osboxes/Downloads/

echo "[Desktop Entry]" > /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Name=STM32CubeMx" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Comment=STMicroelectronics STM32CubeMx" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "GenericName=STM32CubeMX" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Exec=/home/osboxes/STM32CubeMX/STM32CubeMX %F" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Icon=${CUBEMX_Icon}" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Path=/home/osboxes/STM32CubeMX" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Terminal=false" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "StartupNotify=true" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Type=Application" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop
echo "Categories=Development" >> /home/osboxes/Desktop/st-stm32cubeMx.desktop

#For adding to favorites applications
sudo cp /$HOME/Desktop/*.desktop /usr/share/applications/
sudo cp /usr/share/applications/st-stm32cubeide*.desktop /$HOME/Desktop/
sudo chmod +x /usr/share/applications/ST*.desktop
sudo chmod +x /usr/share/applications/st-*.desktop

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
