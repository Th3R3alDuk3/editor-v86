# editor-v86

This is an online **editor** that uses a **client-side x86-emulator (v86)**.  
  
[DEMO](https://editor-v86.glitch.me)  
  
![editor-v86](preview.gif "editor-v86")  
  
I am using some well-known frameworks in this project. 

- [v86](https://github.com/copy/v86)
- [xterm](https://xtermjs.org/)
- [monaco-editor](https://microsoft.github.io/monaco-editor/)  

Because of its usability and good documentation, the [v86 emulator](https://github.com/copy/v86) is suitable for our purposes.  
You can adapt any compiler or programming language as you wish.  
  
## installation

Install [node.js](https://nodejs.org) and download all [dependencies](package.json).  

```
npm install
npm start
```

### electron client (optional)

Start the web service and follow the instructions below.
  
```
cd client

npm install
npm start
```
  
## own bootable (optional)

Build your own bootable distibution.  
I recommend using [qemu](https://www.qemu.org/download) and [packer](https://www.packer.io/downloads).  
  
`cd build/bootables/...`  
  
```
qemu-img create -f raw ...
qemu-system-... -hda ... -cdrom ... --boot d 
```

```
packer build ....json
```
  
*!!!* Make sure you use the `raw` disk image format.  
  
### recommended distributions

- [tinycore](http://tinycorelinux.net/downloads.html)  
- [alpine](https://www.alpinelinux.org/downloads/)  
- [arch32](https://www.archlinux32.org/download/)  
- [buildroot](https://buildroot.org/download.html) 
   - _script-collection to build ure own minimalistic distibution_  
  
*!!!* Make sure you have activated the `serial terminal`.  
  
Copy the image to `public/bootables` and create an entry in `public/emulator.json`. 