#!/bin/bash
mkdir sandbox
cd sandbox
rm -rf *
tar -xvf ../../gnu_src/binutils-2.45.tar.bz2
patch -u binutils-2.45/cpu/or1korbis.cpu -i ../or1korbis.patch
cd binutils-2.45/
rsync -av ../../../gnu_src/cgen .
./configure -target=or1k-elf --disable-werror --prefix=/opt/or1k_toolchain
make -j$(sysctl -n hw.ncpu) all
cd opcodes/
mkdir ~/or1k
ln -s /opt/homebrew/bin/gsed ~/or1k/sed
export PATH=~/or1k/:$PATH
make stamp-or1k
rm -r ~/or1k
cd ..
make -j$(sysctl -n hw.ncpu) all
make install
cd ..
tar -xvf ../../gnu_src/gcc-15.2.0.tar.gz
patch -u gcc-15.2.0/gcc/config/or1k/elf.h -i ../gcc.patch
mkdir gcc
cd gcc/
export CPLUS_INCLUDE_PATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1/
../gcc-15.2.0/configure --target=or1k-elf  --prefix=/opt/or1k_toolchain --with-gnu-as --with-gnu-ld --verbose --enable-languages=c --disable-libssp --disable-shared --disable-werror --with-gmp=/opt/homebrew/ --with-mpfr=/opt/homebrew/ --with-mpc=/opt/homebrew/
make -j$(sysctl -n hw.ncpu) all
make install

