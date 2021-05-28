# editor-v86

[Demo](https://editor-v86.glitch.me/)  
  
![editor-v86](public/assets/gif/editor.gif "editor-v86")  
  
## images

### ArchLinux32

https://github.com/copy/v86/blob/master/docs/archlinux.md  

- `cd scripts/archlinux32`
- `README`
- execute packer `packer build packer.json` 

### TinyCore

http://tinycorelinux.net/  

- `cd scripts/tinycore`
- `README`

### others

Some other images for v86 emulation:  
https://github.com/copy/images  

```
wget -P images/ https://copy.sh/v86/images/{linux.iso,linux3.iso,kolibri.img,windows101.img,os8.dsk,freedos722.img,openbsd.img}
```  

## examples

Some examples for v86 emulation:  
https://github.com/copy/v86/tree/master/examples  

## start NodeJs

```
npm install
npm start
```