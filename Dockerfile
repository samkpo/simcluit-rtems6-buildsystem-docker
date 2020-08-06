FROM ubuntu:latest

RUN apt update && \
	apt install -y --no-install-recommends binutils make patch gcc g++ gdb pax python2.7-dev zlib1g-dev git bison flex texinfo bzip2 xz-utils unzip libtinfo-dev && \
	ln -T /usr/bin/python2.7 /usr/bin/python

RUN git clone git://git.rtems.org/rtems-source-builder.git
RUN cd rtems-source-builder/ && \
	./source-builder/sb-check  && \
	cd rtems/ && \
	../source-builder/sb-set-builder --prefix=/rtems6-tools 6/rtems-arm

RUN git clone git://git.rtems.org/rtems.git
RUN	export PATH=/rtems6-tools/bin:"$PATH" && \
	cd rtems/ && \
	./rtems-bootstrap && \
	mkdir -p build && \
	cd build/ && \
	../configure --prefix=$PROJECTDIR/rtems6-kernel --target=arm-rtems6 --enable-rtemsbsp=stm32f105rc --enable-posix --enable-cxx && \
	make -j8 && \
	make install
