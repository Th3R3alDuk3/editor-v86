"use strict";

/* 
 * V86 EMULATOR
 * https://github.com/Th3R3alDuk3/v86
 * 
 * Changes: 
 * SerialAdapterXtermJS
 * serial0_send_line
 */

var parrot = window.parrot = new V86Starter({        
    wasm_path: "../wasm/v86.wasm",
    memory_size: 64 * 1024 * 1024,
    bios: {
        url: "../assets/bios/seabios.bin",
        size: 128 * 1024,
        async: false
    },
    hda: {
        url: "../assets/images/tinycore.img",
        async: false
    },
    serial_container_xtermjs: _parrot,
    autostart: true
});

/**/

new Promise(function(resolve, reject) { 

    setTimeout(function() {
        reject(new Error("v86 timeout"));
    }, 300 * 1000);

    /**/

    var line = "";

    parrot.add_listener("serial0-output-char", function listener(char) {

        if (char === "\n") {
            line = "";
        } else {
            
            line += char;

            if (line.endsWith("box login:")) {
                parrot.serial0_send_line("tc");
            } else if (line.endsWith("tc@box:~$")) {
                parrot.remove_listener("serial0-output-char", listener);
                parrot.serial0_send_line("clear");
                resolve();
            }

        }            

    });

}).then(function() {
    _button.disabled = false;      
});

/**/     

_button.onclick = function() {

    parrot.serial0_send_line("cat << 'EOF' > ./out") 
    parrot.serial0_send_line(window.editor.getValue())
    parrot.serial0_send_line("EOF");

    parrot.serial0_send_line("clear");
    
    let option = _select.options[_select.selectedIndex];
    switch(option.value) {

        case "c":            
            parrot.serial0_send_line("tcc -run ./out");
            break;

        case "python":
            parrot.serial0_send_line("python2 ./out");
            break;

        default:
            console.log("language not supported");

    }
    
}