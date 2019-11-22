const express = require('express');

const PORT = process.env.PORT || 3000;
const app = express();

app.get('/', (req, res) => {
    const name = req.query.name;
    res.status(200);
    if (name) {
        res.send(`Your name: ${name}`);
    } else {
        res.send('Hello');
    }
});

app.listen(PORT, () => {
    console.info(`Server run on port: ${PORT}`)
});