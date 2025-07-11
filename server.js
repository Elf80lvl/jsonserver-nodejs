const express = require('express');
const cors = require('cors');
const fs = require('fs');
const app = express();

app.use(cors());
app.use(express.json());

const DB_FILE = './db.json';

// Helper to read/write JSON
function readDB() {
  return JSON.parse(fs.readFileSync(DB_FILE, 'utf8'));
}
function writeDB(data) {
  fs.writeFileSync(DB_FILE, JSON.stringify(data, null, 2));
}

// Example GET endpoint
app.get('/users', (req, res) => {
  const db = readDB();
  res.json(db.users);
});

// Example POST endpoint
app.post('/users', (req, res) => {
  const db = readDB();
  db.users.push(req.body);
  writeDB(db);
  res.status(201).json(req.body);
});

app.delete('/users/:id', (req, res) => {
  const db = readDB();
  const userId = req.params.id;
  const newUsers = db.users.filter(user => String(user.id) !== String(userId));
  db.users = newUsers;
  writeDB(db);
  res.status(204).send();
});

app.listen(3000, () => console.log('Server running on port 3000'));