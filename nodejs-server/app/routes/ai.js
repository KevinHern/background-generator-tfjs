// Libraries
const express = require('express');
const router = express.Router();

// Controllers
const ai_background_controller = require('../controllers/aiController');


// Background POST Route
router.post('/background', ai_background_controller.create_background);

// Export module
module.exports = router;