#!/bin/bash

export KBUILD_BUILD_USER=assusdan
export KBUILD_BUILD_HOST=SRT

if [ -f arch/arm64/boot/Image.gz-dtb ]
then
    echo 'Remove kernel...'
    echo ""
    rm arch/arm64/boot/Image*
fi

echo "Git pull..."
git pull >/dev/null
echo ""

echo "Export toolchains..."
export ARCH=arm64 CROSS_COMPILE=../*aarch64*/bin/aarch64-linux-gnu-
echo ""

echo "Make defconfig..."
make benefit_m7_defconfig >/dev/null
echo ""

echo "Start build..."
time make -j4 >/dev/null 2>errors.log
echo ""

if [ ! -f arch/arm64/boot/Image.gz-dtb ]
then
    echo "BUILD ERRORS!"
    echo "BUILD ERRORS!"
    echo "BUILD ERRORS!"
else
    echo 'Moving...'
    cp arch/arm64/boot/Image.gz-dtb /var/www/html/boot.img-kernel
    mv arch/arm64/boot/Image.gz-dtb boot.img-kernel
fi

echo "======================"
echo $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 
echo "======================"
