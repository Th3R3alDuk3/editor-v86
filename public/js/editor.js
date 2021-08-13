"use strict";

/**/

if (monaco_theme == undefined) 
    throw new Error("monaco_theme not defined");

if (!["vs", "vs-dark", "hc-black"].includes(monaco_theme))
    monaco_theme = "vs";

/**/

var editor = document.getElementById("editor");
var select = document.getElementById("select");

/**
 * MONACO-EDITOR 
 * https://microsoft.github.io/monaco-editor/playground.html
 */

require.config({paths: {vs: "node_modules/monaco-editor/min/vs"}});

require(["vs/editor/editor.main"], () => {

    window.editor = monaco.editor.create(
        editor, {
            language: "c",
            theme: monaco_theme,
            value: `#include <stdio.h>
void main() { 
    printf("Hello world!\\n");
}`
        }
    );

    /**/

    select.onchange = event => {
        monaco.editor.setModelLanguage(
            window.editor.getModel(),
            event.target.value
        );
    }

});