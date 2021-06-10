# ArchLinux32

https://archlinux32.org/  

## Installation

### ISOs

https://mirror.archlinux32.org/archisos/

### Dependencies 

#### QEMU

https://www.qemu.org/download/

Download and install `QEMU`.  
Use the following command to test your `ArchLinux32` image.

```
qemu-system-i386 -hda output-qemu/archlinux32.img
```

#### Packer

https://www.packer.io/downloads

Download and install `Packer`.  
Use the following command to build your own `ArchLinux32` image.

```
packer build packer.json
```

## Overview

| script    | description            |
|:---------:|------------------------|
| qemu.sh   | Qemu   (manually)      |
| packer.sh | Packer (automatically) |
| 9p/*.sh   | TODO ...               |