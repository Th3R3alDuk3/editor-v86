"use strict";

/**/

if (bootable == undefined)
    throw new Error("bootable not defined");

/** 
 * TODO: validate bootable
 * 
 * @starter
 * containing options for class V86Starter()
 * @listener 
 * receive certain strings and send corresponding follow-up commands
 * @applications
 * send application-dependent commands
 */

console.log(bootable);

/**/

var _parrot = document.getElementById("parrot");
var _select = document.getElementById("select");
var _button = document.getElementById("button");

/**/

/** 
 * V86 EMULATOR
 * https://github.com/Th3R3alDuk3/v86
 * 
 * Changes: 
 * SerialAdapterXtermJS
 * serial0_send_line
 */

var parrot = new V86Starter(
    Object.assign({}, {
        wasm_path: "assets/js/wasm/v86.wasm",
        memory_size: 512 * 1024 * 1024,
        serial_container_xtermjs: _parrot,
        autostart: true,
        boot_order: 0x132
    }, bootable.starter)
);

/**/

new Promise((resolve, reject) => {

    setTimeout(() => {
        reject(new Error("v86 timeout"));
    }, 300 * 1000);

    /**/

    var line = "";

    parrot.add_listener("serial0-output-char", function listener(char) {

        if (char === "\n") {
            line = "";
        } else {

            line += char;

            bootable.listener.forEach(event => {
                if (line.endsWith(event.receive)) {
                    if (event.send != null) {
                        parrot.serial0_send_line(event.send);
                    } else {
                        parrot.remove_listener("serial0-output-char", listener);
                        parrot.serial0_send_line("clear");
                        resolve();
                    }
                }
            });

        }

    });

}).then(() => {
    _button.disabled = false;
});

/**/

_button.onclick = () => {

    let application = bootable.applications[
        _select.options[_select.selectedIndex].text
    ];

    /**/

    parrot.serial0_send_line("cat << 'EOF' > ./" + application.file)
    parrot.serial0_send_line(window.editor.getValue())
    parrot.serial0_send_line("EOF");

    parrot.serial0_send_line("clear");

    /**/

    parrot.serial0_send_line(application.send);

}