const express = require('express');

const app = express();

/**/

// redirect static files
app.use(express.static('public'));
app.use("/node_modules", express.static('node_modules'));

/**/

app.get('/', (req, res) => {
  res.sendFile("index.html");
});

app.listen(8080, '0.0.0.0', () => {
  console.log('http://0.0.0.0:8080')
});