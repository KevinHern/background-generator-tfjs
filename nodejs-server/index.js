/*
- Express JS (npm install express --save):
	To manage routing and function execution.
- Body Parser (npm install body-parser --save):
	To parse JSON, text, Raw and URL encoded data.
- Tensorflow JS (npm install @tensorflow/tfjs-node):
	Get the tensorflow library to manage all the AI related stuff.
- Nodemon (npm install -g nodemon):
	To automatically reset app when a change was made
- cors (npm install cors --save)
    To be able to handle requests from other domains
*/

// Imports
const express = require('express');
const cors = require('cors');
const path = require('path');
const aiBackgroundController = require('./app/routes/ai');

// Instantiation
var app = express();
app.use(express.json()); // To be able to read and write JSONs
app.use(cors()); // To handle all CORS problems
app.use(express.static(path.join(__dirname, 'public-flutter')));	// Link all the flutter files

// Setting up routes
app.post('/background', aiBackgroundController);
app.all('*', function(req, res) {
	res.redirect("/");
});

// Instantiating the server
/*
	NOTE: There are 2 ports that the app can liston to.
	The process.env.PORT is port dynamically allocated to the app when it has been deployed on a production
	environment.
	The other port is a user assigned port for developing. This port only works locally
*/
var server = app.listen(process.env.PORT || 16000, function () {
    var host = server.address().address
    var port = server.address().port
    
    console.log("App listening at http://%s:%d", host, port)
 })