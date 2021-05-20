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

| script | description                          |
|:------:|--------------------------------------|
| 1.sh   | QEMU ARCHLINUX32 IMAGE               |
| 2.sh   | BOOTABLE ARCHLINUX32 IMAGE           |
| 3.sh   | CUSTOM KERNEL WITH 9P SUPPORT        |
| 4.sh   | ARCHLINUX32 WITH 9P SUPPORT - INTERN |
| 5.sh   | ARCHLINUX32 WITH 9P SUPPORT - EXTERN |