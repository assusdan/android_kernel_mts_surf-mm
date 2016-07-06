#!/bin/bash

export KBUILD_BUILD_USER=assusdan
export KBUILD_BUILD_HOST=SRT

if [ -f arch/arm/boot/zImage-dtb ]
then
    echo 'Remove kernel...'
    rm arch/arm/boot/zImage*
fi

echo "Git pull..."
git pull >/dev/null

echo "Export toolchains..."
export ARCH=arm CROSS_COMPILE=../*5.2*/bin/arm-cortex-linux-gnueabi-

echo "Make defconfig..."
make benefit_m7_defconfig >/dev/null

echo "Start build..."
time make $1 >/dev/null 2>errors.log

if [ ! -f arch/arm/boot/zImage-dtb ]
then
    echo "BUID ERRORS!"
    echo "BUID ERRORS!"
    echo "BUID ERRORS!"
else
    echo 'Moving...'
    mv arch/arm/boot/zImage-dtb /var/www/html/boot.img-kernel
fi

echo "======================"
echo $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 
echo "======================"
