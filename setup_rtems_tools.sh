#!/bin/bash
set +ex

# Create the path
export PROJECTDIR=/opt/build-tools
mkdir $PROJECTDIR
cd $PROJECTDIR
echo $PROJECTDIR

# Clone the source
git clone git://git.rtems.org/rtems-source-builder.git

cd rtems-source-builder/
./source-builder/sb-check

cd rtems
../source-builder/sb-set-builder --prefix=$PROJECTDIR/rtems6-tools 6/rtems-arm
