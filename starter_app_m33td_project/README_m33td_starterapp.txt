##################################################
#M33TD starter app stm32mp2 EV1 board test example
###################################################

use scripts (see also README_install_package.txt) to setup m33td starter app 

-----------------------------------------------------------------
install STM32Cubeide, STM32CubeCubeMP2, tfm for STM32CubeMP2 
and patches for m33TD starter app (cpoject and custom device trees)
------------------------------------------------------------------


#go to script install directory
cd <script_path>
cd install_scripts

#install cubeide tool
source install_cubdeide.sh

#install cubemp2 and tfm
can configure tf-m directory with CUBEMP2_TFM_DIRECTORY_NAME

source install_cube_mp2.sh
source install_cube_mp2_tfm.sh

#go to starter_app_m33td_project script directory
cd <script_path>
cd starter_app_m33td_project

#add custom device tree and patch m33td starter app .cproject
source update_starterapp_m33td_project_settings.sh

----------------------------------------------------------------------------
Build the project with STM32CubeIde
----------------------------------------------------------------------------

#launch stm32cubide
/opt/st/stm32cubeide_2.1.0/stm32cubeide

#Open Project with STM32CubeIDE
-Open from filesystem
/home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.3.0/Projects/STM32MP257F-EV1/Demonstrations/StarterApp_M33TD/STM32CubeIDE/
-go to arm trusted firmware
run cmake configure  (ok) (my_custom dts in the logs)
build trusted firmware (ok)
-non secure firmware 
build ok


----------------------------------------------------------------------------
generate the tsv and flash the image
----------------------------------------------------------------------------

-install mp2 m33td starter package--

	source step3-mp2_m33td_starter_package_install.sh 

-generate the tsv, the raw image (sdcard only), flash raw image with sdcard reader)
	can configure options in the script
	GENERATE_TSV generate tsv and copy binaries from m33td starter app
	GENERATE_RAW_IMAGE generate raw image from the tsv (for sdcard only)
	SDCARD_FLASH_RAW_IMAGE to flash the raw image on sdcard using sdcard reader,
		check sdcard partition with lsblk
		configure SDCARD_FLASH_PARTITION
		uncomment or copy/paste the commands to flash with dd
		(https://wiki.st.com/stm32mpu/wiki/How_to_populate_the_SD_card_with_dd_command)
	SDCARD_FLASH_TSV_WITH_CUBEPROG to flash image on sdcard using STM32CubeProgrammer and tsv
	
	source generate_tsv_and_flash_sdcard_mage.sh




----------------------------------------------------------------------------
to debug, follow wiki article
----------------------------------------------------------------------------

https://wiki.st.com/stm32mpu/wiki/How_to_import,_build_and_debug_STM32CubeMP2_StarterAppM33TD_demonstration_in_STM32CubeIDE

can also try to add print log msg in source code instead of launching debugger
see also the different software components from
https://wiki.st.com/stm32mpu/wiki/How_to_migrate_STM32CubeMPU_examples_from_A35-TD_flavor_to_M33-TD_flavor
boot chain, tfm, non secure application manager

##################################################
To develop your own application
Generate custom device tree from STM32CubeMx
Adapt starter app for your application
or some help to reuse STM32CubeMP2 examples in wiki article
https://wiki.st.com/stm32mpu/wiki/How_to_choose_the_STM32MP2_boot_flavor
https://wiki.st.com/stm32mpu/wiki/How_to_migrate_STM32CubeMPU_examples_from_A35-TD_flavor_to_M33-TD_flavor
https://wiki.st.com/stm32mpu/wiki/How_to_port_StarterApp_to_a_new_board

there are also some known fissues or clock resource configuration with m33 and rif configuration
code generated from STM32CubeMx with ResMgr_Request is incorrect and should be removed
RCC permission access to the M33 is depending on the peripheral type and its RIFSC assignment. 
some scmi service (A35-TD) or PSA clock service (M33-TD) can be needed from m33 firmware to configure clock resource
there are different cases of configuration
according to RCC clock security model and RIF inheritance
see wiki article https://wiki.st.com/stm32mpu/wiki/How_to_configure_system_resources_on_STM32MP2 
some explamples of modification needed for the different configurations
5.1.3. Clock management examples from Cortex-M33
##################################################


##################################################
m33td starter app log examples
##################################################
bl2 (mcu boot)
trusted-firmware-m/bl2/ext/mcuboot/bl2_main.c 
int main(void)
BOOT_LOG_INF("=======MCU Boot debug log=======");


NSAppCore (non secure application manager)
./Utilities/M33TD_NSAppCore/App/Src/nscoreapp_init.c
void NSCoreApp_Init(void

add printf after LoggerTask_Init
    LoggerTask_Init();
    printf("==========NSCoreApp_Init=============================\r\n");

StarterApp_M33TD non secure application

./Projects/STM32MP257F-EV1/Demonstrations/StarterApp_M33TD/CM33/NonSecure/Core/Src/main.c

int main(void)

add printf after NSCoreApp_Init

  NSCoreApp_Init();
  /* Add other task/module initializations here */
  /* e.g., MyCustomTask_Init(); */
  /* USER CODE END AppInit */

  printf("==========Non Secure Starter App m33td after sNSCoreApp_Init =============================\r\n");

##################################################

