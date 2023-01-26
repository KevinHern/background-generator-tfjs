// Imports
const tf = require('@tensorflow/tfjs-node');
const tfnode = require('@tensorflow/tfjs-node');

// Functions


// Used to calculate where the center of the image will be
function centerNormalization(centerPosition=5){
    var scales = [1, 1]

    // Calculate center position scales
    switch(centerPosition){
        // Bottom Left
        case 1:
            scales[0] = 0.25
            scales[1] = 0.75
            break;
        // Bottom Center
        case 2:
            scales[0] = 0.5
            scales[1] = 0.75
            break;
        // Bottom Right
        case 3:
            scales[0] = 0.75
            scales[1] = 0.75
            break;
        // Bottom Left
        case 4:
            scales[0] = 0.25
            scales[1] = 0.5
            break;
        // Bottom Center
        case 5:
            scales[0] = 0.5
            scales[1] = 0.5
            break;
        // Bottom Right
        case 6:
            scales[0] = 0.75
            scales[1] = 0.5
            break;
        // Bottom Left
        case 7:
            scales[0] = 0.25
            scales[1] = 0.25
            break;
        // Bottom Center
        case 8:
            scales[0] = 0.5
            scales[1] = 0.25
            break;
        // Bottom Right
        case 9:
            scales[0] = 0.75
            scales[1] = 0.25
            break;
    }

    return scales;
}

// Returns the cartesian product with offsets
function cartesianProduct(a, b, offsets) {
    return a.reduce((p, x) => [
        ...p,
        ...b.map(y =>[(x-offsets[0])/offsets[0], (y-offsets[1])/offsets[1]])
    ], []);
}

// Creates an image and normalizes based on the center's position
function createImage(width, height, center){
    // Generate all values for the image
    const height_array = [...Array(height).keys()];
    const width_array = [...Array(width).keys()];

    // Calculate center offset
    const center_offsets = [width*center[0], height*center[1]];

    // Perform Cartesian Product between the two arrays
    const image = cartesianProduct(a=width_array, b=height_array, offsets=center_offsets);

    // Return image
    return image;
}

// Generates background using AI
async function generateBackground(imgWidth, imgHeight, neurons, isVortex, centerLocation) {

    /* IMAGE CREATION */
    // Deduce the constants to normalize a center
    const centerNorm = centerNormalization(centerPosition=centerLocation);

    // Create dummy image
    var image = createImage(width=imgWidth, height=imgHeight, center=centerNorm);

    /* BACKGROUND GENERATION */

    // Additional Parameters Initialization
    const activationFunction = isVortex ? "tanh" : "sigmoid";
    const additionalNeurons = isVortex ? 0 : 2;
    const numberLayers = 2;

    // Limiting neurons
    neurons = (neurons < 4) ? 4: (neurons > 7) ? 7: neurons;

    // Array of objects
    var kernelInitializers = [];
    var kernelConstraints = [];
    var layers = [];

    // Objects Instantiations
    for(var i = 0; i < numberLayers; i++) {
        // Kernel Initializer instantiation
        kernelInitializers.push(tf.initializers.randomUniform({minval: -5, maxval: 5}));

        // Kernel Constraint instantiation
        kernelConstraints.push(tf.constraints.maxNorm({maxValue: 5}));

        // Layer Creation
        layers.push(
            tf.layers.dense({
                units: Math.pow(2, neurons + additionalNeurons + 2*(i+1)),
                kernelInitializer: kernelInitializers[0],
                kernelConstraint: kernelConstraints[1],
                useBias: false,
                activation: activationFunction,
            })
        );
    }

    // Adding last layer
    layers.push(
        tf.layers.dense({
            units: 3,
            kernelInitializer: tf.initializers.randomNormal({mean: 0, stddev: 1}),
            useBias: false,
            activation: "sigmoid",
        })
    );
     
    const resultingTensorImage = tf.tidy(() => {
        // Image processing
        var tensor_image = tf.tensor(image);

        for(var i = 0; i < layers.length; i++){
            tensor_image = layers[i].apply(tensor_image);
        }

        // Scaling image from [0, 1] to [0, 255]
        tensor_image = tensor_image.mul(tf.tensor([255, 255, 255]));

        // Casting resulting image to int
        tensor_image = tf.cast(tensor_image, "int32");

        // Reshaping resulting image
        return tensor_image.reshape([width, height, 3]);
    });

    // Encoding image
    const newImg = await tfnode.node.encodeJpeg(resultingTensorImage, format="rgb");
    return Buffer.from(newImg).toString('base64');
}

module.exports = { generateBackground };