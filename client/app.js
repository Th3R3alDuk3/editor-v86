const {app, BrowserWindow} = require("electron");

app.on("ready", () => {

    const window = new BrowserWindow({
        fullscreen: false,
        frame: true,
        backgroundColor: "#000000",
        webPreferences: {
            nodeIntegration: true,
            worldSafeExecuteJavaScript: true
        }
    });

    window.loadURL("http://localhost:8080/");
    
    window.maximize();
    window.focus();

});

app.on("window-all-closed", () => {
    app.quit();
});