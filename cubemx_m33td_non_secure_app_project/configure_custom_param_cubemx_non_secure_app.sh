#!/bin/bash

########################## VM install from PC pre requisites
#!!!!!!!!!!!!!!!check apt-get commands at the end of this script are up to date with the OpenSTLinux release!!!!!!!
######################### VM package install from developer package

OLD_PWD=${PWD}


#CUSTOM_DTS_NAME="my_ev1_mp2_m33td_project_default"
CUSTOM_DTS_NAME="my_ev1_mp2_project_timer_7"
CUSTOM_PRJ_PATH="/home/osboxes/my_cubemx_project/${CUSTOM_DTS_NAME}"
CUSTOM_DTS_PATH="\/home\/osboxes\/my_cubemx_project\/${CUSTOM_DTS_NAME}"
TRUSTED_FW_PATH="${CUSTOM_PRJ_PATH}/CM33/trusted-firmware-m/"
PRJ_CONFIG_PATH_BACKUP="/home/osboxes/cubemx_prj_config"

