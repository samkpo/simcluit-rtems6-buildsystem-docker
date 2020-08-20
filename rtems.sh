#!/bin/bash
set +ex

# Clone repo
git clone git://git.rtems.org/rtems.git
cd rtems

./rtems-bootstrap

mkdir -p build
cd build/

../configure --prefix=$PROJECTDIR/rtems6-kernel --target=arm-rtems6 --enable-rtemsbsp=stm32f105rc --enable-posix --enable-cxx
make -j8
sudo make install

