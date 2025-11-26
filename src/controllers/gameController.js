const db = require('../config/db'); // Importamos el pool de conexión

// Obtenemos la configuración del juego (Esta no cambia)
exports.getGameConfig = (req, res) => {
  res.json({
    QUESTION_TIME_LIMIT: 10,
    POINTS_CORRECT_ANSWER: 50,
    POINTS_COMPLETE_MAZE: 500,
    INVULNERABILITY_DURATION: 1000
  });
};

// Obtenemos preguntas para el juego
exports.getQuestions = async (req, res) => {
  try {
    // Obtener todas las categorías del query string (pueden ser múltiples)
    const categories = req.query.category;
    
    let sql = 'SELECT * FROM questions';
    let params = [];
    
    // Si se especifican categorías (puede ser un string o array)
    if (categories) {
      const categoryArray = Array.isArray(categories) ? categories : [categories];
      
      // Filtrar por múltiples categorías usando IN
      if (categoryArray.length > 0 && !categoryArray.includes('all')) {
        const placeholders = categoryArray.map(() => '?').join(',');
        sql += ` WHERE category IN (${placeholders})`;
        params.push(...categoryArray);
      }
    }
    
    sql += ' ORDER BY RAND() LIMIT 15';
    
    const [questions] = await db.query(sql, params);
    // El driver mysql2 automáticamente parsea los campos JSON
    res.json(questions);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Obtenemos las categorías únicas disponibles
exports.getCategories = async (req, res) => {
  try {
    const [rows] = await db.query('SELECT DISTINCT category FROM questions ORDER BY category ASC');
    const categories = rows.map(row => row.category);
    res.json({ categories });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Obtenemos el resultado del juego (el historial)
exports.saveGameSession = async (req, res) => {
  try {
    const { playerName, score, timeTaken, result, answers } = req.body;

    // El array de 'answers' debe ser convertido a un string JSON para guardarlo
    const answersJSON = JSON.stringify(answers);

    const sql = `INSERT INTO game_sessions 
                 (playerName, score, timeTaken, result, answers) 
                 VALUES (?, ?, ?, ?, ?)`;
    
    await db.query(sql, [playerName, score, timeTaken, result, answersJSON]);
    
    res.status(201).json({ message: 'Historial guardado' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Obtenemos la tabla de puntuaciones
exports.getHighScores = async (req, res) => {
  try {
    const sql = 'SELECT playerName, score FROM game_sessions ORDER BY score DESC LIMIT 10';
    const [scores] = await db.query(sql);
    res.json(scores);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Obtenemos todas las sesiones de juego para el historial
exports.getGameSessions = async (req, res) => {
  try {
    const sql = 'SELECT id, playerName, score, timeTaken, result, createdAt FROM game_sessions ORDER BY createdAt DESC';
    const [sessions] = await db.query(sql);
    res.json(sessions);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};