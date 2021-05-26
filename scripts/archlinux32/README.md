# ArchLinux32

## Archisos

https://mirror.archlinux32.org/archisos/

## Dependencies 

### PACKER

https://www.packer.io/downloads

```
packer build packer-qemu.json
```

### QEMU

https://www.qemu.org/download/

```
qemu-system-i386 -hda output-qemu/archlinux32.img
```

## Overview

| script    | description            |
|:---------:|------------------------|
| qemu.sh   | Qemu   (manually)      |
| packer.sh | Packer (automatically) |
| 9p/*.sh   | TODO                   |