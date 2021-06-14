# tinycore

http://tinycorelinux.net

## installation

https://distro.ibiblio.org/tinycorelinux/install.html
http://tinycorelinux.net/install_manual.html

### iso`s

https://distro.ibiblio.org/tinycorelinux/downloads.html

### dependencies 

#### use qemu

https://www.qemu.org/download/

Download and install `QEMU`.  
Use the following command to test your `tinycore` image.

```bash
qemu-system-i386 -hda output-qemu/tinycore.img
```

#### use packer

https://www.packer.io/downloads

Download and install `Packer`.  
Use the following command to build your own `tinycore` image.

```bash
packer build packer.json
```

### settings

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

```bash
tce-load -wi tcc
tce-load -wi gcc
tce-load -wi python
```

### backup filesystem 

```bash
filetool.sh –b
```

```bash
sudo poweroff
```

#### user login

`box login: tc`

## overview

| script    | description              |
|-----------|--------------------------|
| qemu.sh   | Qemu - (manually)        |
| packer.sh | Packer - (automatically) |