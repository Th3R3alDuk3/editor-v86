const express = require("express");

const app = express();

/**/

// static files
app.use(express.static("public"));
app.use("/node_modules", express.static("node_modules"));

// template engine
app.set("view engine", "pug");
app.set("views", "views");

/**/

const fs = require("fs");

var bootables = JSON.parse(
    fs.readFileSync("public/emulator.json")
);

/**/

app.get("/", (request, response) => {
    response.render("index", {
        monaco_theme: request.query.monaco_theme,
        bootables: JSON.parse(
            fs.readFileSync("public/emulator.json")
        )
    });
});

app.get("/show", (request, response) => {
    response.render("show", {
        monaco_theme: request.query.monaco_theme,
        bootable_name: request.query.bootable_name,
        bootable: JSON.stringify(
            bootables[
                request.query.bootable_name
            ]
        )
    });
});

/**/

app.listen(8080, "0.0.0.0", () => {
    console.log("http://0.0.0.0:8080");
});