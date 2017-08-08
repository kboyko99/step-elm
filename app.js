const express = require('express');
const winston = require('winston');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
const port = 3073;

const logs_path = path.join(__dirname, 'logs');
const logs_filename = path.join(logs_path, 'created-logfile.log');
const config = {
    levels: {
        error: 0,
        debug: 1,
        warn: 2,
        info: 3,
        verbose: 4,
        silly: 5
    },
    colors: {
        error: 'red',
        debug: 'blue',
        warn: 'yellow',
        info: 'green',
        verbose: 'cyan',
        silly: 'magenta'
    }
};
const logger = module.exports = new (winston.Logger)({
    transports: [
        new (winston.transports.Console)({
            colorize: true,
            timestamp: true,
            level: 'silly'
        }),
        new (winston.transports.File)({
            filename: logs_filename,
            timestamp: true,
            level: 'warn'
        })
    ],
    levels: config.levels,
    colors: config.colors,
    exitOnError: false
});

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));

// parse application/json
app.use(bodyParser.json());

app.get('/', function (req, res) {
    logger.info('new / get request');
    res.send('Hello World!');

});

app.post('/login', function (req, res) {
    logger.info('new /login POST request');
    const login = req.body.login;
    const password = req.body.password;
    logger.info('login:'+login + ', password:' + password);
    res.send('Hello World!');
});

app.listen(port, function () {
    console.log('App is listening at port %d.', port);
});