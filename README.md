# simcluit-rtems6-buildsystem-docker

## Building image

```console
docker build -t simcluit-rtems .
```

## Run container

```console
docker run --rm -t -i \
           -v /home/$USER/dev/rtems:/home/developer/dev \
           simcluit_rtems bash
```

## Compiling rtmes

Inside the container:

```console
developer@c4e3c72899f2:~/dev$ rtems
/home/developer/bin/rtems usage:
        c)  Clone repo
        b)  Build
        h)  Display this help
        v)  Verbose mode
developer@c4e3c72899f2:~/dev$ rtems -cb
```

