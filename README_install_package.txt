================================================================================
scripts to install bsp software package for OpenSTLinux release
packages from the release to be copied in a directory shared with the VM or WSL2
================================================================================

There are two kinds of user scripts :

User scripts to install the software packages if not already installed
	stepx_xx.sh 
	
User scripts to install the software tools if not already installed
	install_xx.sh 
	
WSL environment:
	scripts are same for VM or WSL2

----------------------------------------------

User scripts are using following scripts

	-configure_install_OpenSTLinux_release.sh (for configuration script)	
	
	variables for components paths and versions are already configured for the release
	to be configured :  shared directory name	
	
		SHARED_DIR 
 
	-main_script_install_packages.sh (for package install)

	-main_script_install_tools.sh (for tool install)

===============================================


##################################################
##################################################

Example below for stm32mp2 install(similar for stm32mp1)

##################################################


	-create a shared directory between the VM (or WSL) and windows
    example: /mnt/hgfs/shared/release/OpenSTLinux_v6_2_release
    
	-copy all the ST packages zip files into a new sub folder "ST_packages_for_the_release"
	example: copy to /mnt/hgfs/shared/release/OpenSTLinux_v6_2_release/ST_packages_for_the_release
	
	-go in folder "ST_packages_for_the_release"
	-extract stm32mpu_install_build_scripts_vX.Y to this directory (Then scripts files are under stm32mpu_install_build_scripts subfolder )
	
	-go in the folder "stm32mpu_install_build_scripts" 
	edit configure_install_OpenSTLinux_release.sh to update SHARED_DIR with the path to point on "ST_packages_for_the_release" folder
        example : SHARED_DIR=/mnt/hgfs/shared/release/OpenSTLinux_v6_2_release/ST_packages_for_the_release
        
	check also variables for packages have same names
	as the file names for packages in the shared directory 
	for example ( Starter Package, Developer Package, ...)
	OSTL_PACKAGES_MP2_STARTER_PACKAGE
	OSTL_PACKAGES_MP2_SDK_x86_64
	OSTL_PACKAGES_MP2_DEV_PACKAGE_SRC

	-Then all the scripts are run from the folder "stm32mpu_install_build_scripts"
	The scripts are under install_scripts/ sub-folder or under other sub-folders with script to help run m33 firmware examples
 
--------------------------------
 environment configuration
--------------------------------

In Linux Host PC, go in directory shared with the VM or WSL, in SHARED_DIR/script_dev_package_vX.X subfolder 

-apt-get install for the release
(check the apt-get commands correspond to article
https://wiki.st.com/stm32mpu/wiki/PC_prerequisites
)

	 source step1-vm_apt_get_install.sh

-create the directories for the release 
update packages root directory INSTALL_DIR=/local/STM32MPU-OSTL-v${OSTL_VERSION} in : configure_install_OpenSTLinux_release.sh

	source step2-directory_install.sh

-install the starter package (example mp2)

	 source step3-mp2_starter_package_install.sh

-install the SDK (example mp2)

	 source step4-mp2_sdk_dev_package_install.sh

-install the sources of developer package (same sources for mp1 and mp2)

	 source step5-mp_src_dev_package_install.sh

--------------------------------
tool install
--------------------------------

-install STM32Cubeide

	 source install_cubeide.sh

-install STM32CubeMx

	 source install_cubemx.sh

-install STM32CubeProgrammer

	 source install_cubeprog.sh

-install STM32CubeFw packages
	 source install_cube_mp15.sh
	 source install_cube_mp13.sh
	 source install_cube_mp2.sh

-install ddr fw utility
	 source install_ddr_fw_utility.sh

-----------------------------------------------------
To build component in developer package use sdk infos
see sdk-info-build_README
-----------------------------------------------------
see README_build_with_sdk_info.txt to build bsp packages from developer package

-----------------------------------------------------
additional examples for m33 firmware
-----------------------------------------------------

starter_app_m33td_project/
see README_m33td_starterapp.txt

cubemx_m33td_non_secure_app_project/
see README_m33td_cubemx_non_secure_application.txt
see also in this  readme some git commands for project versionning

update_rif_configuration/
see README_update_rif_configuration.txt

m33td_bare_metal_template_project/
see README_m33td_baremetal_template_a35.txt

##################################################

