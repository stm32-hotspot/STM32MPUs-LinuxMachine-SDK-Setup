==============================================

scripts to install and build 
software package for OpenSTLinux release

scripts and packages to be copied 
in a shared directory with the VM or WSL2

===============================================

There are two kinds of user scripts :

User scripts to install the software packages if not already installed

	stepx_xx.sh 

User scripts to install/reinstall sources, clean/build the component  (to be configured depending need)

	xx-build.sh 
 
WSL environment:

	scripts are same for VM or WSL2

	may need to call sudo before launching the script in WSL2

----------------------------------------------

User scripts are calling main script

	install_OpenSTLinux_release.sh
 
variables for components paths and versions are already configured for the release

to be configured :  shared directory name (where are copied packages and scripts)

	SHARED_DIR 
 


install_OpenSTLinux_release.sh script is calling :

	install_packages.sh (for package install and build)

	install_tools.sh (for tool install)

===============================================



----------------------------------------------
----------------------------------------------

Example below for stm32mp2 (similar for stm32mp1)

----------------------------------------------


	create directory shared with the VM or WSL


    
	copy packages and scripts to this directory
 
update variable with this directory name in main script : install_OpenSTLinux_release.sh

	SHARED_DIR
 
check also variables for packages have same names
as the file names for packages in the shared directory 

for example ( Starter Package, Developer Package, ...)

	OSTL_PACKAGES_MP2_STARTER_PACKAGE
	OSTL_PACKAGES_MP2_SDK_x86_64
	OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC
 

----------------------------------------------
First environment configuration :

check the apt-get commands correspond to article
https://wiki.st.com/stm32mpu/wiki/PC_prerequisites

	sudo ./step1-vm_apt_get_install.sh

install the directory for the release at first environment configuration

	INSTALL_DIR=/local/STM32MPU-Ecosystem-v${OSTL_VERSION}

	sudo./step2-directory_install.sh

install the starter package

	sudo ./step3-mp2_starter_package_install.sh

install the SDK

	sudo ./step4-mp2_sdk_dev_package_install.sh

install the sources of developer package

	sudo ./step5-mp2_src_dev_package_install.sh

----------------------------------------------

To build tf-a for a specific board 

configure variables at begin of script
	
example

	tf-a-mp2-build.sh
 
	INSTALL_PACKAGES_T_FA_SRC
	CLEAN_PACKAGES_T_FA_SRC
	BUILD_PACKAGES_T_FA_SRC

configure board name (same as device tree name for ST board or custom board )

	BOARD_NAME
 
check command line 

 	TF_A_CMD_LINE

run the script to build tf-a for the board 

	sudo ./tf-a-mp2-build.sh

same for following scripts

	u-boot-mp2-build.sh 
	optee-mp2-build.sh 
	kernel-mp2-build.sh 

----------------------------------------------

To build fip for a specific board
configure as previously 

	tf-a-mp2-build.sh
	u-boot-mp2-build.sh
	optee-mp2-build.sh

configure 

	fip-mp2-build.sh

	CLEAN_BSP_PACKAGES_FOR_FIP
	INSTALL_BSP_PACKAGES_FOR_FIP
	BUILD_PACKAGES_FIP_FROM_VM_INSTALL must be set to 0
	BUILD_PACKAGES_FIP_FROM_SCRIPTS must be set to 1	
	BOARD_NAME
 
	sudo ./fip-mp2-build.sh

----------------------------------------------

To build fip for all boards
configure 

	fip-mp2-build.sh

	CLEAN_BSP_PACKAGES_FOR_FIP
	INSTALL_BSP_PACKAGES_FOR_FIP
	BUILD_PACKAGES_FIP_FROM_VM_INSTALL must be set to 1
	BUILD_PACKAGES_FIP_FROM_SCRIPTS must be set to 0

	sudo ./fip-mp2-build.sh
----------------------------------------------
----------------------------------------------
