#!/bin/bash
set +ex

help(){
    # display usage if no parameters given
    echo "$0 usage:" && grep ")  \# " $0 |sed 's/\# //'
}

#If no commands, then inform user
if [ -z "$1" ]; then
    help
    exit
fi

# some flags
VERBOSE=false
CLONE_REPO=false
BUILD=false
repo="git://git.rtems.org/rtems.git"
repodir=rtems

clone_repo() {
    git clone $repo
}

build_rtems() {    
    cd $repodir

    ./rtems-bootstrap
    mkdir -p build
    cd build/
    ../configure --prefix=$PROJECTDIR/rtems6-kernel --target=arm-rtems6 --enable-rtemsbsp=stm32f105rc --enable-posix --enable-cxx
    make -j8
}

# Build container
while getopts "cbvh" opt; do
    case $opt in
        c)  # Clone repo
            CLONE_REPO=true
            ;;
        b)  # Build
            BUILD=true
            ;;
        h)  # Display this help
            help
            exit
            ;;
        v)  # Verbose mode
            VERBOSE=true
            ;;
        \?)
            echo "Invalid argument: -$OPTARG"
            ;;
    esac
done

# Build image
if $CLONE_REPO ; then
    $VERBOSE && echo "Clonning repo "
    clone_repo
fi

# Build image
if $BUILD ; then
    $VERBOSE && echo "Building"
    build_rtems
fi
