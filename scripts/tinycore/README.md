# TinyCore

http://tinycorelinux.net

## Installation

https://distro.ibiblio.org/tinycorelinux/install.html

### ISOs

https://distro.ibiblio.org/tinycorelinux/downloads.html

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
...
```

#### install packages

```
tce-load -wi tcc
tce-load -wi gcc
tce-load -wi python
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