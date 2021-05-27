"use strict";

var _editor = document.getElementById("editor"); 
var _select = document.getElementById("select"); 

/**/ 

/*
 * MONACO-EDITOR 
 * https://microsoft.github.io/monaco-editor/playground.html
 */

require.config({paths: {vs: "node_modules/monaco-editor/min/vs"}});

require(["vs/editor/editor.main"], function() {

    var editor = window.editor = monaco.editor.create(
        _editor, {                        
            language: "c",
            theme: "vs-dark",
            value: `#include <stdio.h>

void main() { 
    printf("Hello world!\\n");
}`
        }
    ); 
    
    /**/

    _select.onchange = function(event) {
        monaco.editor.setModelLanguage(
            editor.getModel(), 
            event.target.value
        );
    }

});