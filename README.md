# editor-v86-tcc
  
Some images for v86 emulation:  
https://github.com/copy/images  

```
wget -P images/ https://copy.sh/v86/images/{linux.iso,linux3.iso,kolibri.img,windows101.img,os8.dsk,freedos722.img,openbsd.img}
```  

Some examples for v86 emulation:  
https://github.com/copy/v86/tree/master/examples  
https://copy.sh/v86/

## Installation

### using Qemu & ArchLinux32

https://github.com/copy/v86/blob/master/docs/archlinux.md  

- `cd scripts/archlinux32`
- execute packer `packer build packer.json`  
-- download archlinux32 image  
-- create hda  
-- boot iso and mount hda