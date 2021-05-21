"use strict";

window.onload = () => {

    var terminal = document.getElementById("terminal"); 
    
    var select = document.getElementById("select");   
    var button = document.getElementById("button");
    var loader = document.getElementById("loader");

    /* 
     * MONACO-EDITOR 
     */

    require.config({ 
        paths: { 
            vs: 'node_modules/monaco-editor/min/vs' 
        } 
    });
    
    // https://microsoft.github.io/monaco-editor/playground.html

    /**/

    require(['vs/editor/editor.main'], function () {

        var editor = document.getElementById('editor');

        window.editor = monaco.editor.create(editor, {                        
            language: 'c',
            theme: 'vs-dark',
            value: `#include <stdio.h>

void main() { 
    printf("Hello world!\\n");
}`
        });
        
    });

    /* 
     * V86 EMULATOR 
     */

    var emulator = window.emulator = new V86Starter({        
        wasm_path: "v86/v86.wasm",
        memory_size: 64 * 1024 * 1024,
        bios: {
            url: "bios/seabios.bin",
        },
        vga_bios: {
            url: "bios/vgabios.bin",
        },
        hda: {
            url: "image/archlinux32.img",
            async: true
        },
        serial_container: terminal,
        autostart: true
    });
    
    /**/

    new Promise((resolve, reject) => { 

        setTimeout(() => {
            reject(new Error("timeout ready"));
        }, 300 * 1000);

        emulator.add_listener("serial0-output-line", (line) => {
            if (line.startsWith("Last login:"))
                resolve();
        });

    }).then(() => {
        button.disabled = false;      
        loader.style.visibility = "hidden";
    });   

    /**/

    // TODO: filter textarea

    /**/
    
    select.onchange = (event) => {
        monaco.editor.setModelLanguage(
            window.editor.getModel(), 
            event.target.value
        );
    }

    /**/     

    button.onclick = (event) => {

        let option = select.options[select.selectedIndex];
    
        emulator.serial0_send("cat << 'EOF' > ./out")            
        emulator.serial0_send("\n");
        emulator.serial0_send(window.editor.getValue())
        emulator.serial0_send("\n");
        emulator.serial0_send("EOF");
        emulator.serial0_send("\n");
    
        switch(option.value) {
    
            case "c":
                
                emulator.serial0_send("tcc -run ./out");
                emulator.serial0_send("\n");
    
                break;
    
            case "python":
    
                emulator.serial0_send("python ./out");
                emulator.serial0_send("\n");
    
                break;
    
            default:
                console.log("language not supported");
    
        }
        
    }

    /**/

    window.onresize = () => {
        window.location.reload();
    }
    
}