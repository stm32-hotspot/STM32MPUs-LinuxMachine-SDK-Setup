# STM32MPUs Linux Machine SDK setup



##### **Purpose**



To adapt the OpenSTLinux board support package (BSP) to a customer design, it is necessary to rebuild the BSP, including the boot chain and the Linux kernel, with the STM32MPU software development kit (SDK), which contains the compilation chain, and the STM32MPU Developer Package, which contains the source code. An Ubuntu Linux machine is required for this task. The Ubuntu Linux machine can be a PC with a native Ubuntu Linux operating system or a virtual Ubuntu Linux machine on Windows Subsystem for Linux 2 (WSL2) or VMware on a Windows PC.



To set up the Ubuntu Linux machine with a given version of OpenSTlinux release, a set of scripts is available on the ST GitHub Hotspot site at the following link:  [STM32MPUs-LinuxMachine-SDK-Setup](https://github.com/stm32-hotspot/STM32MPUs-LinuxMachine-SDK-Setup). A GitHub tag corresponds to each OpenSTLinux release.





From the ZIP packages on the ST website, the scripts can install on the Ubuntu machine the Starter Package, the Developer Package with its SDK, the Distribution Package, the STM32CubeMP and the tools: STM32CubeProgrammer, STM32CubeIDE and STM32CubeMX. The scripts install also the required Debian packages for build tool chain and the ST tools.





##### **Ubuntu PC setup instructions**



The example below is for the STM32MP2 installation. The same procedure applies to STM32MP1.



1. On Ubuntu PC, create a shared directory between the virtual machine (VM or WSL2) environment and Windows PC.
Example: /mnt/hgfs/shared/release/OpenSTLinux\_v6\_2\_release
2. Go to the shared directory
Example /mnt/hgfs/shared/release/OpenSTLinux\_v6\_2\_release
3. git clone https://github.com/stm32-hotspot/STM32MPUs-LinuxMachine-SDK-Setup.git
4. git checkout remotes/origin/OpenSTLinux\_X\_Y -b local\_ecosystemX\_Yn
The script files are then available in the stm32mpu\_install\_build\_scripts subfolder.
5. In the shared directory, create a subfolder named ST\_packages\_for\_the\_release.
Example:/mnt/hgfs/shared/release/OpenSTLinux\_v6\_2\_release/ST\_packages\_for\_the\_release
On the ST website, download the .zip files for MP2 that are listed in stm32mpu\_install\_build\_scripts/configure\_install\_OpenSTLinux\_release.sh into ST\_packages\_for\_the\_release subfolder

**Starter Package image**
[MP2-START-A35-TD zip, MP2-START-M33-TD zip](https://www.st.com/en/embedded-software/stm32mp2starter.html)
[MP1-START](https://www.st.com/content/st_com/en/products/embedded-software/mcu-and-mpu-embedded-software/stm32-embedded-software/stm32-mpu-openstlinux-distribution/stm32mp1starter.html)
**Software Development Kit(SDK)**
[MP2-DEV-x86 zip, MP2-DEV-Arm zip](https://www.st.com/en/embedded-software/stm32mp2dev.html)
[MP1-DEV-x86 zip, MP1-DEV-Arm zip](https://www.st.com/content/st_com/en/products/embedded-software/mcu-and-mpu-embedded-software/stm32-embedded-software/stm32-mpu-openstlinux-distribution/stm32mp1dev.html)
**Developer package source code**
[MP2-DEV-SRC zip](https://www.st.com/en/embedded-software/stm32mp2dev.html)
[MP1-DEV-SRC zip ](https://www.st.com/content/st_com/en/products/embedded-software/mcu-and-mpu-embedded-software/stm32-embedded-software/stm32-mpu-openstlinux-distribution/stm32mp1dev.html)
**STM32Cube firmware packages for coprocessor**
[STM32CubeMP2 zip](https://www.st.com/content/st_com/en/products/embedded-software/mcu-and-mpu-embedded-software/stm32-embedded-software/stm32cube-mcu-mpu-packages/stm32cubemp2.html)
[STM32CubeMP15 zip](https://www.st.com/content/st_com/en/products/embedded-software/mcu-and-mpu-embedded-software/stm32-embedded-software/stm32cube-mcu-mpu-packages/stm32cubemp1.html)
[STM32CubeMP13 zip](https://www.st.com/content/st_com/en/products/embedded-software/mcu-and-mpu-embedded-software/stm32-embedded-software/stm32cube-mcu-mpu-packages/stm32cubemp13.html)
**Tools**
[STM32CubeProgrammer](https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-programmers/stm32cubeprog.html)
[STM32CubeIDE](https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-ides/stm32cubeide.html)
[STM32CubeMX](https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-configurators-and-code-generators/stm32cubemx.html)

6. Go to the stm32mpu\_install\_build\_scripts folder.
7. Edit configure\_install\_OpenSTLinux\_release.sh and update the SHARED\_DIR variable so that it points to the ST\_packages\_for\_the\_release folder. Example: SHARED\_DIR=/mnt/hgfs/shared/release/OpenSTLinux\_v6\_2\_release/ST\_packages\_for\_the\_release





###### **Environment configuration**



On the Linux host PC, go to the directory that is shared with the VM or WSL2 environment, and then go to the SHARED\_DIR/../*stm32mpu\_install\_build\_scripts* subfolder, *run the below scripts from it*.



1. Install the Debian packages for the tools (The package list is available in the article https://wiki.st.com/stm32mpu/wiki/PC_prerequisites).
*source step1-vm\_apt\_get\_install.sh*
2. Create a directory tree
*Edit* the root directory of the tree in configure\_install\_OpenSTLinux\_release.sh
Example INSTALL\_DIR=/local/STM32MPU-OSTL-v${OSTL\_VERSION}
*source step2-directory\_install.sh*
3. Extract the starter package for images of the STM32MP2 ST reference boards.
*source step3-mp2\_starter\_package\_install.sh*
4. Extract the software development kit (SDK) for STM32MP2.
*source step4-mp2\_sdk\_dev\_package\_install.sh*
5. Install the developer package sources. These sources are the same for STM32MP1 and STM32MP2. Source packages include TF-A, OP-TEE, U-Boot, and the Linux kernel.
*source step5-mp\_src\_dev\_package\_install.sh*



Tool installation



Install STM32CubeIDE: *source install\_cubeide.sh*

Install STM32CubeMX: *source install\_cubemx.sh*

Install STM32CubeProgrammer: *source install\_cubeprog.sh*

Install the STM32Cube firmware packages for coprocessor: *source install\_cube\_mp15.sh source install\_cube\_mp13.sh source install\_cube\_mp2.sh*

Install the DDR firmware utility. *source install\_ddr\_fw\_utility.sh*



##### **Build information**



To build components in the developer package, use the SDK information in [README\_build\_with\_sdk\_info.txt](README_build_with_sdk_info.txt) It allow to rebuild device tree, the different boot chain binaries and the Linux kernel.





##### **Prerequisites**



Use an Ubuntu 22.04 or 24.04 (64-bit) Linux machine. The machine can be a native Ubuntu PC or a virtual machine that uses WSL2 or VMware on a Windows PC.



The supported Ubuntu version is listed at https://wiki.st.com/stm32mpu/wiki/PC_prerequisites#Virtual_machine_system.

