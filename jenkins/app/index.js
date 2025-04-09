// app/index.js
const http = require('http');

const server = http.createServer((req, res) => {
    res.end('Hello, Docker World!');
});

server.listen(3000, () => {
    console.log('✅ Server running on http://localhost:3000');
});
