# editor-v86

[Demo](https://editor-v86.glitch.me/)  
  
![editor-v86](preview.gif "editor-v86")  
  
## build bootables

Build your own bootable linux distibution.  
I recommend using [Qemu](https://www.qemu.org/download/) and [Packer](https://www.packer.io/downloads).  
  
`cd build/bootables/...`  
  
```bash
qemu-img create -f raw ...
qemu-system-... -hda ... -cdrom ... --boot d 
```

```bash
packer build ....json
```
  
*!!!* Make sure you use the disk image `raw` format.  
  
### recommended linux

- TinyCore
- AlpineLinux  
- ArchLinux32  
  
*!!!* Make sure that you activate the `serial terminal`.  
  
Copy the created disk image to `public/assets/bootables` and create an entry in `public/emulator.json`. 
  
## start application

```
npm install
npm start
```