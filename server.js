const express = require('express');
const path = require('path');

const app = express();

app.use(express.static(path.join(__dirname, 'src')));
app.use(express.static(path.join(__dirname, 'build/contracts')));

app.get('/', (req, res) => {
  res.render('index.html');
});

app.listen(3000, (error) => {
  if (error) throw error;
  console.log('Server started on port 3000');
});
