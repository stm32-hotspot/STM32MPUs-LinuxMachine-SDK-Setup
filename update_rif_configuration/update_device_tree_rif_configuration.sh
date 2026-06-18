#!/bin/bash

#####
rif configuration update prototype
TESTS TODO
#####

OLD_PWD=${PWD}


source ../configure_OpenSTLinux_release_install.sh

source configure_custom_device_tree_param_for_rif_configuration.sh

#update rif configuration
echo "=====update rif configuration======="

echo "rif dts file ${RIF_DTS_PATH}/${RIF_DTS_NAME}"

cd ${RIF_DTS_PATH}


if [[(${RIF_OPEN_CONFIGURATION} -eq 1)]];
then
RIF_CMD="RIFPROT(STM32MP25_RIFSC_TIM7_ID, RIF_UNUSED, RIF_UNLOCK, RIF_NSEC, RIF_PRIV, RIF_UNUSED, RIF_SEM_DIS, RIF_CFDIS)"
sed -i "s/.*STM32MP25_RIFSC_TIM7_ID.*/${RIF_CMD}/" ${RIF_DTS_NAME}
fi

if [[(${RIF_CID1_ONLY} -eq 1)]];
then
RIF_CMD="RIFPROT(STM32MP25_RIFSC_TIM7_ID, RIF_UNUSED, RIF_UNLOCK, RIF_NSEC, RIF_PRIV, RIF_CID1, RIF_SEM_DIS, RIF_CFEN)"
sed -i "s/.*STM32MP25_RIFSC_TIM7_ID.*/${RIF_CMD}/" ${RIF_DTS_NAME}

fi

if [[(${RIF_CID2_ONLY} -eq 1)]];
then
RIF_CMD="RIFPROT(STM32MP25_RIFSC_TIM7_ID, RIF_UNUSED, RIF_UNLOCK, RIF_NSEC, RIF_PRIV, RIF_CID2, RIF_SEM_DIS, RIF_CFEN)"
sed -i "s/.*STM32MP25_RIFSC_TIM7_ID.*/${RIF_CMD}/" ${RIF_DTS_NAME}

fi

if [[(${RIF_CID1_AND_CID2} -eq 1)]];
then
RIF_CMD="RIFPROT(STM32MP25_RIFSC_TIM7_ID, RIF_CID1_BF|RIF_CID2_BF, RIF_UNLOCK, RIF_NSEC, RIF_PRIV, RIF_UNUSED, RIF_SEM_EN, RIF_CFEN)"
sed -i "s/.*STM32MP25_RIFSC_TIM7_ID.*/${RIF_CMD}/" ${RIF_DTS_NAME}

fi

echo "rif cmd ${RIF_CMD}"

cd ${OLD_PWD}

