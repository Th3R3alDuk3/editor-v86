"use strict";

/**/


if (monaco_theme == undefined) 
    throw new Error("monaco_theme not defined");

if (!["vs", "vs-dark", "hc-black"].includes(monaco_theme))
    monaco_theme = "vs";

/**/

var _editor = document.getElementById("editor");
var _select = document.getElementById("select");

/**/

/**
 * MONACO-EDITOR 
 * https://microsoft.github.io/monaco-editor/playground.html
 */

require.config({paths: {vs: "node_modules/monaco-editor/min/vs"}});

require(["vs/editor/editor.main"], () => {

    var editor = window.editor = monaco.editor.create(
        _editor, {
            language: "c",
            theme: monaco_theme,
            value: `#include <stdio.h>

void main() { 
    printf("Hello world!\\n");
}`
        }
    );

    /**/

    _select.onchange = event => {
        monaco.editor.setModelLanguage(
            editor.getModel(),
            event.target.value
        );
    }

});