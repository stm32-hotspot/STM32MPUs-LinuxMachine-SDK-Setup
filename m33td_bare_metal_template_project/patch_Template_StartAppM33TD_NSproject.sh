#!/bin/bash

OLD_PWD=${PWD}

source ../configure_OpenSTLinux_release_install.sh

BOARD=STM32MP215F-DK
export PJR_NAME=Template_StarterApp_M33TD
export CUBEMP2_StarterAPP_BM_DIR=${HOME}/STM32Cube/Repository/STM32Cube_FW_MP2_V${CUBEMP2_BM_VERSION}/Projects/${BOARD}/Templates/${PJR_NAME}


if [ -f ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/.cproject.ori ] 
then
echo "${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/.cproject already patched"


else

cp -v ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/.cproject ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/.cproject.ori
echo "Add in ${PJR_NAME}_CM33_NonSecure project "A35_BM" in MCU GCC Compiler > Preprocessor"
awk '
/superClass="com.st.stm32cube.ide.mcu.gnu.managedbuild.tool.c.compiler.option.definedsymbols"/ { in_block=1 }
in_block && /<\/option>/ {
    print "\t\t\t\t\t\t\t\t\t<listOptionValue builtIn=\"false\" value=\"A35_BM\"/>"
    in_block=0
}
{ print }
' ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/.cproject > file.tmp && mv file.tmp ${CUBEMP2_StarterAPP_BM_DIR}/STM32CubeIDE/CM33/NonSecure/.cproject

fi


