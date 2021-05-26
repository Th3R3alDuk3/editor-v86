# TinyCore

## ISO

https://distro.ibiblio.org/tinycorelinux/downloads.html

## Installation

https://distro.ibiblio.org/tinycorelinux/install.html

## Settings

### Serial Console

https://mivilisnet.wordpress.com/2018/12/24/microcore-on-the-serial-console/

`vi /mnt/sda1/tce/boot/extlinux/extlinux.conf`
```
..." console=ttyS0,9600
```

`vi /opt/bootsync.sh`
```
...
/sbin/getty 9600 ttyS0
...
```

### Packages

```
tce-load -wi tcc
tce-load -wi gcc
tce-load -wi python
```

### Backup 

```
filetool.sh –b

sudo poweroff
```

`box login: tc`