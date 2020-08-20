FROM ubuntu:latest

RUN apt update && \
	apt install -y --no-install-recommends binutils make patch gcc g++ gdb pax python2.7-dev zlib1g-dev git bison flex texinfo bzip2 xz-utils unzip libtinfo-dev sudo && \
	ln -T /usr/bin/python2.7 /usr/bin/python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Build the rtems tools
COPY setup_rtems_tools.sh /
RUN /bin/bash /setup_rtems_tools.sh && rm /setup_rtems_tools.sh
ENV PATH="/opt/build-tools/rtems6-tools/bin:${PATH}"
RUN echo $PATH

# Let's create a user so we don't mess with the permissions
RUN useradd -ms /bin/bash developer
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER developer
WORKDIR /home/developer
RUN mkdir /home/developer/dev
VOLUME /home/developer/dev

# Copy and set up rtems script
RUN mkdir /home/developer/bin
COPY rtems-utils.sh /home/developer/.rtems-utils.sh
RUN ln -s /home/developer/.rtems-utils.sh /home/developer/bin/rtems
ENV PATH /home/developer/bin:$PATH

# Build the rtems tools
# COPY setup_rtems_tools.sh /
# RUN /bin/bash /setup_rtems_tools.sh && rm /setup_rtems_tools.sh
# ENV PATH="/opt/build-tools/rtems6-tools/bin:${PATH}"
# RUN echo $PATH
