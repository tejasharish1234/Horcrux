const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

// Setup MySQL connection
const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'root',
  database: 'test'
});

// Connect to MySQL
db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL!');
});

// Endpoint to get users
app.get('/users', (req, res) => {
  db.query('SELECT * FROM users', (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

// Endpoint to add a user
app.post('/users', (req, res) => {
  const { name, email } = req.body;
  db.query('INSERT INTO users (name, email) VALUES (?, ?)', [name, email], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json({ id: result.insertId, name, email });
  });
});

// Start server
app.listen(3000, () => {
  console.log('Server running on port 3000');
});
