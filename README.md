# editor-v86

This is an online **editor** that uses a **client-side emulator (v86)**.  
  
[Demo](https://editor-v86.glitch.me)  
  
![editor-v86](preview.gif "editor-v86")  
  
## build bootables

Build your own bootable linux distibution.  
I recommend using [Qemu](https://www.qemu.org/download) and [Packer](https://www.packer.io/downloads).  
  
`cd build/bootables/...`  
  
```bash
qemu-img create -f raw ...
qemu-system-... -hda ... -cdrom ... --boot d 
```

```bash
packer build ....json
```
  
*!!!* Make sure you use the disk image `raw` format.  
  
### recommended distributions

- TinyCore
- AlpineLinux  
- ArchLinux32  
- Buildroot _(script-collection to build ure own minimalistic linux-distibution)_  
  
*!!!* Make sure that you activate the `serial terminal`.  
  
Copy the created disk image to `public/bootables` and create an entry in `public/emulator.json`. 
  
## start application

Install [node.js](https://nodejs.org) and download all dependencies.  

```bash
npm install
npm start
```

### electron client

```bash
cd client

npm install
npm start
```
