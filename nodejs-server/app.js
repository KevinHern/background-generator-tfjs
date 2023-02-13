var express = require('express');
var path = require('path');
const cors = require('cors');
//var cookieParser = require('cookie-parser');
//var logger = require('morgan');

//var weatherAPIRouter = require('./routes/weather');

var app = express();

app.use(cors()); // To handle all CORS problems
//app.use(logger('dev'));
app.use(express.json());
//app.use(express.urlencoded({ extended: false }));
//app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public-flutter')));

//app.use('/api/weather', weatherAPIRouter);

var server = app.listen(process.env.PORT || 16000, function () {
    var host = server.address().address
    var port = server.address().port
    
    console.log("App listening at http://%s:%s", host, port)
 })