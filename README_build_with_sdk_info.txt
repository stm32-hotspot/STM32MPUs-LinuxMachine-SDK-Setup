example to build compoment in developer package for stm32mp2 evaluation board without external DT
and stm32mp2 dk board with external DT

----------------------------
1/ generate Generate the board scripts for all the mp1 or mp2 ST board,under sdk-infos-1.1-r0/examples
----------------------------

cd sdk-infos-1.1-r0
./generated_build_script-stm32mpx.sh stm32mp2

----------------------------
2/copy from sdk-infos-1.1-r0/examples/ folder the needed ST board script and rename it with the DT name
(One script by DT : sdk_compilation_stm32mp<1|2>_<DT name>.example.sh)

here stm32MP2-EV1 board with the DT in source codes (stm32mp257f-ev1.dts) 

cd ..
cp sdk-infos-1.1-r0/examples/sdk_compilation_stm32mp2_
stm32mp257f-ev1.example sdk_compilation_stm32mp2_stm32mp257f-ev1.example.sh

----------------------------
3/ configure sdk_compilation_stm32mp2_stm32mp257f-ev1.example.sh file
----------------------------
configure sdk path
sdk_absolute_path=/local/OSTL-v6.2.0/Developer-Package/SDK_MP2_x86_64
 
configure DT (ext dt, or source dt)
your_board_name="stm32mp257f-ev1"
 
Configure storage
your_storage_boot_scheme_cortex_a="optee-sdcard
 
configure external dt path - let "externaldt_path=" if dt is embeded in sources files, ie not in external dt
externaldt_path=

----------------------------
to build bsp components, linux kernel
----------------------------


 ./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh extract (dezip&patch of all the components)
 ./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh compile-for-fip (compile boot chain)
 ./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh deploy-for-fip (create fip)
 ./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh linux-stm32mp (compile linux kernel)

./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh cleanall (remove all the components, to restart from scratch)

linux kernel build has some options for linux-stm32mp (see help)
         -dtb
         -dtbs
         -images
         -modules
		 
sudo ./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh linux-stm32mp images
sudo ./sdk_compilation_stm32mp2_stm32mp257f-ev1_example.sh linux-stm32mp dtb

each component can be compiled separatly (see help)

----------------------------
example for stm32mp135 dk board with EXTERNAL DT stm32mp135d-dk-ostl.dts
----------------------------
cd ..
cp sdk-infos-1.1-r0/examples/sdk_compilation_stm32mp1_stm32mp135f-dk.example sdk_compilation_stm32mp2_stm32mp135f-dk-ostl.example.sh
 
configure sdk path
sdk_absolute_path=/local/OSTL-v6.2.0/Developer-Package/SDK_MP1_x86_64
 
configure DT (ext dt, or source dt)
your_board_name="stm32mp135f-dk-ostl"
 
Configure storage
your_storage_boot_scheme_cortex_a="optee-sdcard
 
configure external dt path
externaldt_path=/local/OSTL-v6.2.0/Developer-Package/stm32mp-openstlinux-6.6-yocto-scarthgap-mpu-v26.02.18/sources/ostl-linux/external-dt-v6.0-stm32mp-r3-r0/external-dt-v6.0-stm32mp-r3