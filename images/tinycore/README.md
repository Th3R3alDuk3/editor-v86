# TinyCore

http://tinycorelinux.net

## Installation

https://distro.ibiblio.org/tinycorelinux/install.html
http://tinycorelinux.net/install_manual.html

### ISOs

https://distro.ibiblio.org/tinycorelinux/downloads.html

### Dependencies 

#### QEMU

https://www.qemu.org/download/

Download and install `QEMU`.  
Use the following command to test your `TinyCore` image.

```
qemu-system-i386 -hda output-qemu/tinycore.img
```

#### Packer

https://www.packer.io/downloads

Download and install `Packer`.  
Use the following command to build your own `TinyCore` image.

```
packer build packer.json
```

### Settings

#### enable serial console

https://mivilisnet.wordpress.com/2018/12/24/microcore-on-the-serial-console/

`vi /mnt/sda1/tce/boot/extlinux/extlinux.conf`
```bash
...
..." console=ttyS0,9600
```

`vi /opt/bootsync.sh`
```bash
...
/sbin/getty 9600 ttyS0
```

#### install packages

```
tce-load -wi tcc gcc python
```

### backup filesystem 

```
filetool.sh –b
```

```
sudo poweroff
```

#### user login

`box login: tc`