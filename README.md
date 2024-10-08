scripts to install and build software package for the OpenSTLinux release

scripts and packages to be copied in a shared directory with the VM or WSL2

main script 

	install_VM_OpenSTLinux_v5_1.sh

to configure 

	SHARED_DIR 
 
for path variable in the script

variables for components paths and versions are already configured for the release

this script is calling :

	install_packages.sh (for package install and build)

 	install_tools.sh (for tool install)
	
New scripts created  (to be configured depending need : install/reinstall sources, clean/build the component):

	stepx_xx.sh 
			to install the software packages if not already installed

	xx-build.sh 
			to build the bsp components

   
			
WSL environment:

scripts are same for VM or WSL2

may need to call sudo before launching the script in WSL2

for example

	sudo ./step5-mp2_src_dev_package_install.sh

	sudo ./fip-mp2-build.sh
