
#############################################################################
#A35 bare metal template application from CubeFW project with CubeIDE
#MP215F-DK board in AAchr32 with SDcard
#This application is using 2 STM32CubeIde project
-one project for A35 non secure
-one project for m33td (non secure project and trusted-firmware-m project)
###############################################################################


Pre-requisite: OTP#16 a35_mode bit has to be set to 1. We need to write 0x00000010

This how-to uses scripts (explained in README_install_package.txt) 
according to the info in configure_OpenSTLinux_release_install.sh that contains the all the relase info (version-tags/install path) 

-----------------------------------------------------------------
install STM32Cubeide, STM32CubeCubeMP2 for bare metal, tfm inside STM32CubeMP2 
------------------------------------------------------------------

go to folder stm32mpu_install_build_scripts/install_scripts/

#install cubeide tool

	source install_cubdeide.sh


#install cubemp2 bare metal (under /home/<user>/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/)

	source install_cube_mp2_bm.sh


#install cubemp2 fm (under /home/<user>/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Middleware/Third_Party/)

	source install_cube_mp2_tfm_bm.sh

cd -

----------------------------------------------------------------------------
Build the projects with STM32CubeIde
----------------------------------------------------------------------------

###launch stm32cubide
/opt/st/stm32cubeide_2.1.1/stm32cubeide

----------------------------------------------------------------------------
1-A35 Template_CA35_Secure project
----------------------------------------------------------------------------

###build ca35-fw - "Template_CA35_Secure" Project  => Template_CA35_Secure.bin 
-Open from filesystem the "Template_CA35_Secure" project
/home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/Templates/Template_CA35_Secure/STM32CubeIDE
-right click on Template_CA35_Secure project
select build project


----------------------------------------------------------------------------
2-M33TD Template_StarterApp_M33TD project (non secure m33fw + trusted-firmware-m)
----------------------------------------------------------------------------
###Building Cortex-M33 Binaries (including TFM)

##build TF-M Secure and sign: tfm and bl2/mcuboot => bl2.stm32, ddr_phy_signed.bin, ca35_fw_signed.bin from Template_CA35_Secure.bin

-Open from filesystem the "Template_StarterApp_M33TD" project
/home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/Templates/Template_StarterApp_M33TD/STM32CubeIDE


-patch .cproject of Template_StarterApp_M33TD_CM33_trusted-firmware-m (Properties > C/C++ Build > Cmake Settings -> Other Option field)
to update the MP215F-DK baremetal dt path + add ca35-fw path

go to folder stm32mpu_install_build_scripts/m33td_bare_metal_template_project

	source patch_Template_StartAppM33TD_TFM_project.sh

-right click on Template_StarterApp_M33TD_CM33_trusted-firmware-m project
select : CMake Configure

-right click on Template_StarterApp_M33TD_CM33_trusted-firmware-m project
select build project

##building CA35 Template_StarterApp Non-Secure + assemble tfm & m33fw Ns + sign => Template_StarterApp_M33TD_CM33_NonSecure_tfm_s_ns_signed.bin (in .tsv, is tfm_s_ns_signed.bin)

-patch .cproject to add flag A35_BM in MCU GCC Compiler > Preprocessor
go to folder stm32mpu_install_build_scripts/m33td_bare_metal_template_project

	source patch_Template_StartAppM33TD_NSproject.sh

-right click on Template_StarterApp_M33TD_CM33_NonSecure project
select build project


----------------------------------------------------------------------------
Custom Binaries flash the image
----------------------------------------------------------------------------

-create custom binary foder from Prebuild binaries and above binaries ( tfm_s_ns_signed.bin ca35_fw_signed.bin bl2.stm32 ddr_phy_signed.bin)
in ${CUBEMP2_BM_DIR}/Projects/${BOARD}/External_Loader/Custom_Binaries/SD_Ext_Loader/aarch32

go to folder stm32mpu_install_build_scripts/m33td_bare_metal_template_project

	source update_custom_bin_sd_ext_loader_bm.sh

-flash with cubeprogrammer

Change the boot pin of the board to be in "Forced serial boot for flash memory programming" as explained in the wiki
https://wiki.st.com/stm32mpu/wiki/STM32MP215x-DKx_-_hardware_description#Boot_switches
b0-b4 = 0000

-reset the board and enable in host PC the ROM code DFU usb device.

cd /home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/External_Loader/Custom_Binaries/SD_Ext_Loader/aarch32/
STM32_Programmer_CLI -c port=usb1 -w ./FlashLayout_sdcard_stm32mp215f-dk-cm33tdcid-BM.tsv

-----
Start 
-----

https://wiki.st.com/stm32mpu/wiki/STM32MP215x-DKx_-_hardware_description#Connecting_USB_to_TTL_serial_cables
STLINKV3-mini, 20pins cable plugged CN5 for A35 trace
STLINKV3-SET 3 wires plugged into VCPM33 for M33 traces

Open Two consoles
• One with "minicom -D /dev/ttyACM0" for M33 traces
• One with "minicom -D /dev/ttyACM1" for A35 traces

Change the boot pin of the board to be in "Boot from microSD card for M33-TD flavor" as explained in the wiki
https://wiki.st.com/stm32mpu/wiki/STM32MP215x-DKx_-_hardware_description#Boot_switches
b0-b4 = 1110

Boot
• Hit reset button

Log appears (see below) 
A35fw : LD3 orange 1s blinks every 1s
M33fw : LD4 green 2s blinks every 2s
 
----------------------------
Debug Template_CA35_Secure
----------------------------

Rebulid TF-M to enable the debug on TF-M,M33-NS fw,A35-S fw
-right click on Template_StarterApp_M33TD_CM33_trusted-firmware-m project select Properties > C/C++ Build > Cmake Settings -> Other Option field
to add : -DDEBUG_AUTHENTICATION=FULL

-Modify the TF-M code to not be stuck during the debug.
Open "trusted-firmware-m/platform/ext/target/stm/common/stm32mp2xx/bl2/boot_hal.c", go inside "stm32mp2_init_debug" and comment the "WFI"

Rebuild Template_StarterApp_M33TD_CM33_trusted-firmware-m
-right click on Template_StarterApp_M33TD_CM33_trusted-firmware-m project
select : CMake Configure
If you already made the CMake configuration in the past, !!you must override it by selecting "Delete and Reconfigure"!! (otherwise the new TF-M config is not used).
-right click on Template_StarterApp_M33TD_CM33_trusted-firmware-m project
select build project

Assemble TF-M and M33NSfw and sign to get Template_StarterApp_M33TD_CM33_NonSecure_tfm_s_ns_signed.bin (in .tsv,is tfm_s_ns_signed.bin)
-right click on Template_StarterApp_M33TD_CM33_NonSecure project
select build project


Modify the code Template_CA35_Secure to be able to wait the debugger in the main.
Open "STM32CubeMP2-1.4.0.rc6/Projects/STM32MP215F-DK/Templates/Template_CA35_Secure/CA35/Secure/Src/main.c"
and add a debug loop at the beginning of the main:
// Debug loop
int wait = 1;
  while (wait){};

Disable Optimization 
-right click on "Template_CA35_Secure", go in "C/C++ Build" -> "Settings" -> "MCU GCC Compiler" -> "Optimization" (!not debug level in "...-> Debugging"!)
and change "Optimization Level" to "-None (-O0)"
-Apply and Close

Rebuild Template_CA35_Secure
-Right click on "Template_CA35_Secure" and "Build Project"

Re-sign Template_CA35_Secure.bin to get ca35_fw_signed.bin
-right click on Template_StarterApp_M33TD_CM33_trusted-firmware-mproject
select build project

Update the board
-go to folder stm32mpu_install_build_scripts/m33td_bare_metal_template_project
	source update_custom_bin_sd_ext_loader_bm.sh
-set b0-b4 = 0000
-reset the board and enable in host PC the ROM code DFU usb device.

-cd /home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/External_Loader/Custom_Binaries/SD_Ext_Loader/aarch32/
STM32_Programmer_CLI -c port=usb1 -w ./FlashLayout_sdcard_stm32mp215f-dk-cm33tdcid-BM.tsv

#Create debug configuration
Right Click on "Template_CA35_Secure" project and right click to get Debug As > Debug configurations...
Double click STM32 C/C++ Application and create debug configuration:
• In Debugger tabulation:
• Load Mode and select thru JTAG/SWD link (Engineering mode).
• In Startup tabulation:
• Remove all the Initialization Commands
• Disable in Runtime Options the Resume checkbox.
• Select the Load Image and Symbols element click Edit and disable Download.
And click on Apply.
Disconnect STLINK of M33, because CubeIDE lost with 2 STLINK 
Then on Debug
You should be in the debug loop in STM32CubeMP2-1.4.0.rc6/Projects/STM32MP215F-DK/Templates/Template_CA35_Secure/CA35/Secure/Src/main.c

----------------------------------------------------------------------------
 Prebuild binarires are aleady present in Custom Binaries but if you need to rebuild
----------------------------------------------------------------------------

#compile CA35_Jumper
go to folder stm32mpu_install_build_scripts/m33td_bare_metal_template_project
	source mk_jumper_bm.sh

#Compile External_Mem_Loader=> External_Mem_Loader_A35.bin
-Open from filesystem 
/home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/External_Loader/External_Mem_Loader/STM32CubeIDE
right click on External_Mem_Loader_A35
click on ‘Debug_aarch32’ configuration
select build project

#compile SD_Ext_Loader=> SD_Ext_Loader_A35.bin
-Open from filesystem 
/home/osboxes/STM32Cube/Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/External_Loader/SD_Ext_Loader/STM32CubeIDE
right click on SD_Ext_Loader_A35
click on ‘Debug_aarch32’ configuration
select build project


Entry Links
----------------------------------------------------------------------------
Understanding Template_StarterApp_M33TD  
https://github.com/PRG-MPU-ALPHA/STM32CubeMP2/blob/main/Projects/STM32MP215F-DK/Templates/Template_StarterApp_M33TD/README.md
----------------------------------------------------------------------------

----------------------------------------------------------------------------
Understanding how to migrate M33 example into A35
https://wiki.st.com/stm32mpu/wiki/How_to_migrate_STM32CubeMPU_examples_from_A35-TD_flavor_to_M33-TD_flavor
----------------------------------------------------------------------------

----------------------------------------------------------------------------
M33 log
[INF] init:pmic@33 STPMIC:31 V1.2

[INF] welcome to MCUboot: v2.1.3-stm32mp-r2
[INF] cpu: STM32MP215FAN Rev.Z
[INF] board: stm32mp215f dk
[INF] board ID: MB2059 Var1.0 Rev.B-02
[INF] dts: stm32mp215f-dk-cm33tdcid-bm-sdcard-bl2.dts
[INF] boot device: sdmmc1
[INF] mcu sysclk: 300000000
[WRN] *******************************  >>>>>> when TFM compiled with -DDEBUG_AUTHENTICATION=FULL
[WRN] * The debug port is full open *
[WRN] * wait debugger interrupt     *
[WRN] ******************************* >>>>>>>
[INF] Loading gpt header

[INF] Starting bootloader
[WRN] This device was provisioned with dummy keys.

[WRN] This device is NOT SECURE

[INF] PSA Crypto init done, sig_type: EC-P256
[INF] Primary   slot: version=0.1.0+0
[INF] Secondary slot: version=0.1.0+0
[INF] Image 2 RAM loading to 0xe065000 is succeeded.
[INF] Image 2 loaded from the primary slot
[INF] BL2: image 2, enable DDR-FW
[INF] Primary   slot: version=1.0.0+0
[INF] Secondary slot: version=1.0.0+0
[INF] Image 1 RAM loading to 0x82000000 is succeeded.
[INF] Image 1 loaded from the primary slot
[INF] Primary   slot: version=2.1.0+0
[INF] Secondary slot: version=2.1.0+0
[INF] Image 0 RAM loading to 0x80000000 is succeeded.
[INF] Image 0 loaded from the primary slot
[INF] Bootloader chainload address offset: 0x104400
[INF] Jumping to the first image slot
[INF] init:pmic@33 STPMIC:31 V1.2
[INF] welcome to TF-M: v2.1.3-stm32mp-r2
[INF] board: stm32mp215f dk
[INF] dts: stm32mp215f-dk-cm33tdcid-bm-sdcard-s.dts
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
[NS] [INF] STM32Cube FW version: v1.4.0-rc6 
[NS] [INF] [WdgMonitor] watchdog timeout: 120000ms
[NS] [INF] [RemoteProc] starting copro cpu@0... (pending)
[NS] [INF] [RemoteProc] copro cpu@0 started.

----------------------------------------------------------------------------

----------------------------------------------------------------------------
A35 log
***** New CA35 Clock Source   : PLL1      *
*     CA35 Frequency : 1200000 KHz  *

----------------------------------------------------------------------------


----------------------------------------------------------------------------
Code of M33 Starter App NS, the user app FREERTOS task blinks the orange led
.../Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Utilities/M33TD_NSAppCore/App/Src/userapp_task.c
----------------------------------------------------------------------------

----------------------------------------------------------------------------
Code of A35 Secure to blink the green led
../Repository/STM32Cube_FW_MP2_V1.4.0.rc9/Projects/STM32MP215F-DK/Templates/Template_CA35_Secure/CA35/Secure/Src/main.c





