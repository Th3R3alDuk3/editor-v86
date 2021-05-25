# editor-v86

[Demo](https://editor-x86.glitch.me/)  
    

Some examples for v86 emulation:  
https://github.com/copy/v86/tree/master/examples  
https://copy.sh/v86/

## Create Images

### ArchLinux32

https://github.com/copy/v86/blob/master/docs/archlinux.md  

- `cd scripts/archlinux32`
- execute packer `packer build packer.json`  
-- download archlinux32 image  
-- use `qemu`  
--- create hda  
--- boot iso and mount hda

### TinyCore

http://tinycorelinux.net/  

- `cd scripts/tinycore`
- read `README`
-- download tinycore image
-- use `qemu`  
--- create hda  
--- boot is and mount hda

### Other Images

Some other images for v86 emulation:  
https://github.com/copy/images  

```
wget -P images/ https://copy.sh/v86/images/{linux.iso,linux3.iso,kolibri.img,windows101.img,os8.dsk,freedos722.img,openbsd.img}
```  

## Start NodeJs

```
npm install
npm start
```