 #
 # 64bit kernel compiling script
 #
 # Copyright (c) 2019 Raymond Miracle
 #
 
#! /bin/sh

#Kernel building script

KERNEL_DIR=$PWD

function colors {
ORNG=$'\033[0;33m'
CYN=$'\033[0;36m'
PURP=$'\033[0;35m'
BLINK_RED=$'\033[05;31m'
BLUE=$'\033[01;34m'
BLD=$'\033[1m'
GRN=$'\033[01;32m'
RED=$'\033[01;31m'
RST=$'\033[0m'
YLW=$'\033[01;33m'
}

colors;

function clone {
        echo "${RED}#  WELCOME LETS START BUILDING THE KERNEL NOW!!!!    #"
        sudo rm -rf out
        sudo rm -rf outdir
        sudo rm -rf output
        sudo rm -rf aarch64-linux-android-4.9
        sudo rm -rf anykernel2
        sudo rm -rf Toolchain
        sudo rm -rf toolchain
        sudo rm -rf gcc
	echo " "
	echo "${YLW}####################################"
	echo "${BLD}#       CLONING TOOLCHAIN          #"
	echo "${YLW}####################################"
	sleep 2
	git clone https://github.com/raymondmiracle/Toolchain toolchain
	echo "${YLW}####################################"
	echo "${RST}#    CLONING TOOLCHAIN DONE        #"
        echo "${YLW}####################################"
	sleep 2
	echo "${YLW}####################################"
	echo "${CYN}#       CLONING AnyKernel          #"
	echo "${YLW}####################################"
	git clone --depth=1 --no-single-branch https://github.com/raymondmiracle/anykernel2
	echo "${YLW}####################################"
        echo "${RST}#    CLONING AnyKernel DONE        #"
        echo "${YLW}####################################"
}

function exports {
        echo "${RED}#######..MAKING EXPORTS.. ##########"
	export KBUILD_BUILD_USER="Ray-Miracle"
	export KBUILD_BUILD_HOST="OmegaHOST"
	export ARCH=arm64
	export SUBARCH=arm64
}

function build_kernel {
    echo "${ORNG}Checking Defconfig"
	if [ -f $KERNEL_DIR/arch/arm64/configs/hots_bsp_defconfig ]
	then 
		DEFCONFIG=hots_bsp_defconfig
	elif [ -f $KERNEL_DIR/arch/arm64/configs/omega_defconfig ]
	then
		DEFCONFIG=omega_defconfig
	else
		echo "${RED}Defconfig Mismatch"
		echo "${RED}Exiting in 5 seconds"
		sleep 5
		exit
	fi
	
	make O=out $DEFCONFIG
	echo "${YLW}#######################"
	echo "${CYN}#BUILDING KERNEL NOW..#"
	echo "${PURP}#######################"
	BUILD_START=$(date +"%s")
	make -j$(nproc --all) O=out \
		CROSS_COMPILE=$KERNEL_DIR/toolchain/bin/aarch64-linux-android- 2>&1 | tee logcat.txt
	BUILD_END=$(date +"%s")
	BUILD_TIME=$(date +"%Y%m%d-%T")
	DIFF=$(($BUILD_END - $BUILD_START))	
}

function check_kernel {
	if [ -f $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb ]
	then 
		echo -e "${GRN}#################################################"
		echo -e "${GRN}#Kernel Built Successfully in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds..!!#"
		echo -e "${GRN}#################################################"
	else 
		echo -e "${RED}#################################################"
		echo -e "${RED}#Kernel failed to compile after $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds..!! Uploading logs asap#"
		echo -e "${RED}#################################################"
		curl -F file=@logcat.txt http://0x0.st
	fi	
}

function zip_And_upload {
	if [ -f $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb ]
	then 
		echo "${RED}###################################"
		echo "${RST}#ZIPPING AND UPLOADING THE KERNEL.#"
		echo "${ORNG}###################################"
		mv $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb anykernel2/Image.gz-dtb
		cd anykernel2
		mv Image.gz-dtb zImage
		zip -r9 omega-kernel-$BUILD_TIME * -x .git README.md
		curl -F file=@omega-kernel-${BUILD_TIME}.zip http://0x0.st
		echo "${BLD}#######"
		echo "${RST}#DONE.#"
		echo "${CYN}#######"
		cd ..
	fi
}

clone
exports
build_kernel
check_kernel
zip_And_upload
