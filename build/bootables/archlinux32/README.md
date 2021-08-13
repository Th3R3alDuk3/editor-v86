# archlinux32

https://archlinux32.org/  

## overview

| script    | description              |
|-----------|--------------------------|
| qemu.sh   | Qemu - (manually)        |
| packer.sh | Packer - (automatically) |
| 9p/*.sh   | TODO ...                 |

## installation

https://wiki.archlinux.org/title/installation_guide

### iso`s

https://mirror.archlinux32.org/archisos/

### dependencies 

#### use qemu

https://www.qemu.org/download/

Download and install `QEMU`.  
Use the following command to test your `archlinux32` image.

```
qemu-system-i386 -hda output-qemu/archlinux32.img
```

#### use packer

https://www.packer.io/downloads

Download and install `Packer`.  
Use the following command to build your own `archlinux32` image.

```
packer build packer.json
```