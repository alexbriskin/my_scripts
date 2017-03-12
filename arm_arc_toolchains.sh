#!/bin/bash -eu

pushd /tmp

# ARM toolchain
wget http://docs/docs/it/install/GCC/ARM/gcc-arm-none-eabi-4_8-2014q3-atk-1.0.0-linux.tar.xz
tar -xf gcc-arm-none-eabi-4_8-2014q3-atk-1.0.0-linux.tar.xz
sudo mkdir -p /tools/gcc/arm
sudo mv gcc-arm-none-eabi-4_8-2014q3-atk-1.0.0 /tools/gcc/arm

# ARC toolchain
wget http://docs/docs/it/install/GCC/Synopsys/gcc-arc-elf32-4.8-2014.08-rc1-4.0.tar.xz
tar -xf gcc-arc-elf32-4.8-2014.08-rc1-4.0.tar.xz
sudo mkdir -p /tools/gcc/synopsys
sudo mv gcc-arc-elf32-4.8-2014.08-rc1-4.0 /tools/gcc/synopsys

popd
