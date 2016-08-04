#!/bin/bash

export KBUILD_BUILD_USER=assusdan
export KBUILD_BUILD_HOST=SRT

if [ -f arch/arm/boot/zImage-dtb ]
then
    echo 'Remove kernel...'
    rm arch/arm/boot/zImage*
fi

echo "Git pull..."
echo ""
git pull >/dev/null
echo ""

echo "Export toolchains..."
export ARCH=arm CROSS_COMPILE=../*5.2*/bin/arm-cortex-linux-gnueabi-
echo ""

echo "Make defconfig..."
make benefit_m7_defconfig >/dev/null
echo ""

echo "Start build..."
time make -j4 >/dev/null 2>errors.log
echo ""
echo ""

if [ ! -f arch/arm/boot/zImage-dtb ]
then
    echo "BUILD ERRORS!"
    echo "BUILD ERRORS!"
    echo "BUILD ERRORS!"
else
    echo 'Moving...'
    cp arch/arm/boot/zImage-dtb /var/www/html/boot.img-kernel
    mv arch/arm/boot/zImage-dtb boot.img-kernel
fi
echo ""
echo ""

echo "======================"
echo $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 
echo "======================"
