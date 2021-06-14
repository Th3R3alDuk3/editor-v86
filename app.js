const express = require("express");

const app = express();

/**/

// static files
app.use(express.static("public"));
app.use("/node_modules", express.static("node_modules"));

// template engine
app.set("view engine", "pug");
app.set("views", "public/views");

/**/

const fs = require("fs");

var bootables = JSON.parse(
    fs.readFileSync("public/emulator.json")
);

/**/

app.get("/", (request, response) => {
    response.render("index", {
        bootables: bootables
    });
});

app.get("/bootable", (request, response) => {
    response.render("bootable", {
        name: request.query.name,
        bootable: bootables[
            request.query.name
        ]
    });
});

/**/

app.listen(8080, "0.0.0.0", () => {
    console.log("http://0.0.0.0:8080")
});