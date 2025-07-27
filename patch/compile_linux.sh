#!/bin/bash
mkdir sandbox
cd sandbox
rm -rf *
tar -xvf ../../gnu_src/binutils-2.44.tar.bz2
patch -u binutils-2.44/cpu/or1korbis.cpu -i ../or1korbis.patch
cd binutils-2.44/
rsync -av ../../../gnu_src/cgen .
./configure -target=or1k-elf --disable-werror --prefix=/opt/or1k_toolchain
make -j$(nproc) all
cd opcodes/
make stamp-or1k
cd ..
make -j$(nproc) all
make install
cd ..
tar -xvf ../../gnu_src/gcc-15.1.0.tar.gz
patch -u gcc-15.1.0/gcc/config/or1k/elf.h -i ../gcc.patch
mkdir gcc
cd gcc/
../gcc-15.1.0/configure --target=or1k-elf  --prefix=/opt/or1k_toolchain --with-gnu-as --with-gnu-ld --verbose --enable-languages=c --disable-libssp --disable-shared --disable-werror
make -j$(nproc) all
make install

