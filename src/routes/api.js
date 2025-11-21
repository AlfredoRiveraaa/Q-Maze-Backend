const express = require('express');
const router = express.Router();
const gameController = require('../controllers/gameController');

// --- Rutas de la API ---

// GET /api/config -> Devuelve la configuración del juego
router.get('/config', gameController.getGameConfig);

// GET /api/questions -> Devuelve preguntas aleatorias
router.get('/questions', gameController.getQuestions);

// GET /api/questions/categories -> Devuelve las categorías disponibles
router.get('/questions/categories', gameController.getCategories);

// POST /api/game/session -> Guarda el resultado de una partida
router.post('/game/session', gameController.saveGameSession);

// GET /api/scores -> Devuelve las mejores puntuaciones
router.get('/scores', gameController.getHighScores);

module.exports = router;