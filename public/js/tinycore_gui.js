"use strict";

var _parrot = document.getElementById("parrot"); 

/* 
 * V86 EMULATOR
 * https://github.com/Th3R3alDuk3/v86
 * 
 * Changes: 
 * SerialAdapterXtermJS
 * serial0_send_line
 */

var answer = confirm("Download image using an asynchronous connection?");

var parrot = new V86Starter({        
    wasm_path: "../wasm/v86.wasm",
    memory_size: 128 * 1024 * 1024,    
    vga_memory_size: 16 * 1024 * 1024,
    bios: {
        url: "../assets/bios/seabios.bin",
        size: 128 * 1024,
        async: false
    },
    vga_bios: {
        url: "../assets/bios/vgabios.bin",
        size: 35 * 1024,
        async: false
    },
    hda: {
        url: "../assets/images/tinycore_gui.raw",
        async: answer
    },
    screen_container : _parrot,
    autostart: true,
    boot_order: 0x132
});