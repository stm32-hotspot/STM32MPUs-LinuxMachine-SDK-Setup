##################################################
##################################################
#M33TD non secure application generated from STM32CubeMx
example with stm32mp2 EV1 board
and some git commands for project versionning
###################################################


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

############
generate project from STM32CubeMx and  build cubemx project
example with stm32mp2 ev1 default (or adding timer 7 activated on m33)
############

############
Open Project from STM32CubeMx
my_cubemx_project_m33/CM33
create stm32 cmake project for tf-m33td using existing cmake source
name trusted-firmware-m
default location
from
<>/STM32Cube_FW_MP2_V1.3.0/Middlewares/Third_Party/
then
STM32MP257FAIx" for STM32MP257F-EV1
M33 CPU
Click on Finish.

(.cproject is created in my_project_m33/CM33/trusted-firmware-m)

############

############
#go to cubemx_m33td_non_secure_app_projec script directory
cd <script_path>
cd cubemx_m33td_non_secure_app_projec

can use scripts update_cubemx_non_secure_app_m33td_project_settings.sh

edit configure_custom_param_cubemx_non_secure_app.sh
configure projet name and path in the script

update_cubemx_non_secure_app_m33td_project_settings.sh script update some settings of cubemx projects 
-trusted-firmware-m cmake settings
call script or go to properties /settings /C++ Build
modify cmake options (other options)
-DDEBUG_AUTHENTICATION=FULL -DTFM_PLATFORM=<prj_path>/CM33/PlatformTF-MDTFM_
TOOLCHAIN_FILE=toolchain_GNUARM.cmake -DTFM_PROFILE=profile_medium -DSTM32_M33TDCID=ON -DCMAKE_BUILD_TYPE=Relwithdebinfo -DSTM32_BOOT_DEV=sdmmc1 -
DDTS_EXT_DIR=<prj_path>/CM33/DeviceTree/ -DDTS_BOARD_BL2=<prj_path>/mcuboot/<prj_path_dts_name>-mx.
dts -DDTS_BOARD_S=<prj_path>/tf-m/<prj_path_dts_name>-mx.dts

-non secure app linker script and startup file
copy from m33td starter app stm32mp2xx_DDR_m33_ns.ld to non secure app and modify CM33/NonSecure/;cproject
use startup_stm32mp257cxx_m33.s for non secure app

source update_cubemx_non_secure_app_m33td_project_settings.sh

############

############

other settings need to be done manually in STM32Cubide

configure manually
-trusted-firmware-m cmake settings
go to properties /settings /C++ Build /behavior
add "--target install
 Build (incremental build))			--target install
(this will aloow to export tfm include to the non secure app)

-non secure app
go to properties /settings /C++ Build 
add -j1 in post build command

############
build trusted-firmware-m 
cmake configure rusted-firmware-m 
build trusted-firmware-m (or build with hammer)

############

############

############
need to generate again project from STM32CubeMx
clean rebuild trusted-firmware-m
build non secure app (or build with hammer)
check DEBUG build option (if defined there is a wile loop at begin of non secure app)
############

############
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
some examples of modification needed for the different configurations
5.1.3. Clock management examples from Cortex-M33
see also reference manual table 133 kernel clock distribution overview
-5.1.3.1. Example 1: ADC3 -- bus clock enabled directly via RIFSC inheritance
(same for tim7 no flexgen associated)
-5.1.3.2. Example 2: I2C1 -- flexgen kernel clock via SCMI (A35-TD) or PSA clock service (M33-TD)
(flex gen associated to kernel clock)
need service for clock scmi (A35td) or psa (m33td)
-5.1.3.3. Example 3: GPIOF -- no action from M33, clock pre-enabled by Secure world↑

#degug rif iac errors
for iac error and rif configuration
https://wiki.st.com/stm32mpu/wiki/How_to_analyze_IAC_%26_SERC_errors
Ref manual 9.3 RIFSC implementation
See table for RIF-aware peripherals 
############

############
git versionning

at begin, at root of project folder

git init
git config --global user.email "xxxx@yyy"
git config --global user.name "user name"

git branch -m my_cubemx_project_m33_v1_0

then at each step
git add --all
git commit -m "xxx comment modification"

at end of modifications
git tag v1_x

update modifications in remote git repository
git push --dry-run origin my_cubemx_project_m33_v1_0:my_cubemx_project_m33_v1_0
git push  origin my_cubemx_project_m33_v1_0:my_cubemx_project_m33_v1_0
update modifications from remote to local directory
git fetch 
git pull --rebase origin my_cubemx_project_m33_v1_0

after new STM32CubeMx generation

If modification is in user section, not modified by STM32CubeMx
If modification is outside user section (example hal, …)

Following command can help

search for commit of patch <patch comment>

 git log  --oneline | grep print
2457461 print after non secure app init

generate the patch with git format-patch
git format-patch -1  2457461
patch file created
0001-print-after-non-secure-app-init.patch

commit the modifications after cubemx new generation
git add --all
git commit -m "new mx generation"

apply the patch to current version with git apply 
git apply --3way 0001-print-after-non-secure-app-init.patch
or git cherry-pick 2457461
or resolve the conflicts

possible to merge several commits in one commit

other useful git commands
gitk --all (graphical view)
git show
git reset --hard HEAD 

more help on git commands
https://git-scm.com/learn
https://git-scm.com/book/en/v2
############



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
To develop your own application on your own board
some help to reuse STM32CubeMP2 examples in wiki article
see also starterapp example that can be adapted to your project
README_test_m33td_application.txt
https://wiki.st.com/stm32mpu/wiki/How_to_migrate_STM32CubeMPU_examples_from_A35-TD_flavor_to_M33-TD_flavor
https://wiki.st.com/stm32mpu/wiki/How_to_port_StarterAppM33TD_demonstration_to_a_new_board
##################################################


##################################################
cubemx app log examples
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

cube mx  non secure application

<prj_path>/CM33/NonSecure/Core/Src/main.c

int main(void)

add printf after NSCoreApp_Init

  NSCoreApp_Init();
  /* Add other task/module initializations here */
  /* e.g., MyCustomTask_Init(); */
  /* USER CODE END AppInit */

  printf("==========Non Secure CubeMx m33td after sNSCoreApp_Init =============================\r\n");

##################################################

##################################################
tips
##################################################

boot log
[INF][Crypto] Init HW accelerator...                                            
[INF][Crypto] Init HW accelerator... complete.  

this means waiting in while loop at begin of starter app
need to undefine DEBUG build option

see m33_log_cubemx_non_secure_app_m33td.txt for complete log
[INF] welcome to TF-M: v2.1.3-stm32mp-r2                                        
[INF] board: stm32mp257f-mx                                                     
[INF] dts: stm32mp257f-my_mp2_ev1_default_m33td_timer7-mx.dts                   
Booting TF-M v2.1.3                                                             
[WAR] This device was provisioned with dummy keys.                              
[WAR] This device is NOT SECURE                                                 
[Sec Thread] Secure image initializing!                                         
INFO: low power firmware "v1.0.0"                                               
[    0.000000] SCP-firmware v2.13.0-stm32mp-r3                                  
[    0.000000]                                                                  
[    0.000000] [FWK] Module initialization complete!                            
[INF][Crypto] Init HW accelerator...                                            
[INF][Crypto] Init HW accelerator... complete.                                  
[NS] [INF] Non-Secure system starting...                                        
[NS] [INF] STM32Cube FW version: v1.3.0-rc0                                     
=======my cubemx timer 7 non secure app[NS] [INF] [WdgMonitor] watchdog timeouts
[NS] [INF] [RemoteProc] starting copro cpu@0... (pending)                       
[NS] [INF] [RemoteProc] copro cpu@0 started. 

