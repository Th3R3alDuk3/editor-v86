# alpinelinux

https://alpinelinux.org

## installation

https://wiki.alpinelinux.org/wiki/Installation

### iso`s

https://alpinelinux.org/downloads/

```
setup-alpine
```

### dependencies 

#### use qemu

https://www.qemu.org/download/

Download and install `QEMU`.  
Use the following command to test your `alpinelinux` image.

```
qemu-system-i386 -hda output-qemu/alpinelinux.img
```

#### use packer

https://www.packer.io/downloads

Download and install `Packer`.  
Use the following command to build your own `alpinelinux` image.

```
packer build packer.json
```

### settings

#### enable serial console

https://wiki.alpinelinux.org/wiki/Enable_Serial_Console_on_Boot

`vi /etc/update-extlinux.conf`
```
...
default_kernel_opts="console=ttyS0,9600 quiet ..."
serial_port=0
serial_baud=9600
timeout=1
...
```
```
update-extlinux
reboot
```

#### install packages

```
apk add gcc
apk add python3
```
Compile `tcc` for ure system ...
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

poweroff
```

## overview

| script    | description              |
|-----------|--------------------------|
| qemu.sh   | Qemu - (manually)        |
| packer.sh | Packer - (automatically) |