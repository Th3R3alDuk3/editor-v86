# AlpineLinux

https://alpinelinux.org

## Installation

https://wiki.alpinelinux.org/wiki/Installation

### ISOs

https://alpinelinux.org/downloads/

```
setup-alpine
```

### Settings

#### enable serial console

https://wiki.alpinelinux.org/wiki/Enable_Serial_Console_on_Boot

`vi /etc/update-extlinux.conf`
```
...
default_kernel_opts="console=ttyS0,9600 quiet ..."
serial_port=0
serial_baud=9600
...
```
```
update-extlinux
```

#### install packages

```
apk update

apk add gcc
apk add python3
```
```
apk add musl-dev
apk add --virtual ./build-deps make

wget http://mirror.netcologne.de/savannah/tinycc/tcc-0.9.27.tar.bz2
tar -xf tcc-0.9.27.tar.bz2
cd tcc-0.9.27

./configure --config-musl
make 
make install

apk del ./build-deps
```