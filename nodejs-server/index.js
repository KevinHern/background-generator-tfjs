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
const aib = require('./lib/ai_image_functions');

// Instantiation
var app = express();
app.use(express.json()); // To be able to read and write JSONs
app.use(cors()); // To handle all CORS problems
app.use(express.static(path.join(__dirname, 'public-flutter')));	// Link all the flutter files

// This is the main URL to obtain the background
app.post('/background', async function (req, res) {
	// Sanity Check: Checking if the x field in the JSON exists
	if (true){		
		try{
            // Create cool background
            img = await aib.generateBackground(
                imgWidth=req.body.width, imgHeight=req.body.height, neurons=req.body.neurons,
                isVortex=req.body.vortex, centerLocation=req.body.centerPosition,
				red=req.body.red, green=req.body.green, blue=req.body.blue,
			);

            // Return the result
            res.status(200).json({image: img});
		}
		catch(error){
			console.log(error);
			res.sendStatus(500);
		}
	}
	// Send error if the X field does not exist in the JSON
	else{
		res.sendStatus(500);
	}
	
})

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