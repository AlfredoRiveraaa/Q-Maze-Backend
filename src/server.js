const path = require('path'); // <-- Importa el módulo 'path'

// Carga dotenv usando una ruta absoluta y robusta
require('dotenv').config({ path: path.join(__dirname, '../.env') });

const express = require('express');
const cors = require('cors');
const db = require('./config/db');

// --- BLOQUE DE DEPURACIÓN ---
console.log('--- Variables de Entorno Cargadas ---');
console.log('DB_HOST:', process.env.DB_HOST);
console.log('DB_USER:', process.env.DB_USER);
console.log('DB_PASSWORD:', process.env.DB_PASSWORD ? 'Cargada (oculta)' : 'NO cargada');
console.log('DB_NAME:', process.env.DB_NAME);
console.log('-------------------------------------');
// -------------------------------------------

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());

// --- Conexión ---
db.query('SELECT 1')
  .then(() => console.log('Conectado a la base de datos MySQL'))
  .catch(err => console.error('Error al conectar a MySQL:', err));

// Rutas
const apiRoutes = require('./routes/api');
app.use('/api', apiRoutes);

// Iniciar Servidor
app.listen(PORT, () => {
  console.log(`Servidor backend corriendo en http://localhost:${PORT}`);
});