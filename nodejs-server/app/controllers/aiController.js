// Imports
const aib = require('../../src/ai_image_functions');

// Generate background
exports.create_background = async function (req, res) {
	// Sanity Check: Checking if all the body fields in the JSON exist
	const widthCheck = typeof req.body.width !== 'undefined' && req.body.width !== null && Number.isInteger(req.body.width);
	const heightCheck = typeof req.body.height !== 'undefined' && req.body.height !== null && Number.isInteger(req.body.height);
	const neuronsCheck = typeof req.body.neurons !== 'undefined' && req.body.neurons !== null && Number.isInteger(req.body.neurons);
	const vortexCheck = typeof req.body.vortex !== 'undefined' && req.body.vortex !== null && typeof req.body.vortex == "boolean";
	const centerPositionCheck = typeof req.body.centerPosition !== 'undefined' && req.body.centerPosition !== null && Number.isInteger(req.body.centerPosition);
	const redCheck = typeof req.body.red !== 'undefined' && req.body.red !== null && Number.isInteger(req.body.red);
	const greenCheck = typeof req.body.green !== 'undefined' && req.body.green !== null && Number.isInteger(req.body.green);
	const blueCheck = typeof req.body.blue !== 'undefined' && req.body.blue !== null && Number.isInteger(req.body.blue);

	const sanityCheckTest = widthCheck && heightCheck && neuronsCheck &&
		vortexCheck && centerPositionCheck && redCheck && greenCheck && blueCheck;

	// Executing
	if (sanityCheckTest){		
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
};