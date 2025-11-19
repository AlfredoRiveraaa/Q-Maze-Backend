-- qmaze_schema.sql
-- Script para crear la base de datos y tablas del backend Q-Maze.
-- 
-- PASOS DE EJECUCIÓN:
-- 1. Asegúrate de que tu servicio MySQL (XAMPP/WAMP) esté corriendo.
-- 2. Ejecuta este script en tu herramienta de gestión (phpMyAdmin, Workbench, DBeaver, etc.).

-- 1. CREAR LA BASE DE DATOS
-- Usamos IF NOT EXISTS para evitar errores si ya existe
CREATE DATABASE IF NOT EXISTS qmaze;

-- 2. SELECCIONAR LA BASE DE DATOS
USE qmaze;

-- 3. CREAR LA TABLA DE PREGUNTAS (questions)
-- DROP TABLE es opcional, pero ayuda a limpiar si se ejecuta varias veces
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100) DEFAULT 'General',
    text VARCHAR(255) NOT NULL,
    -- Guardamos las opciones como un array JSON de strings
    options JSON NOT NULL, 
    -- Índice de la respuesta correcta (0, 1, 2, o 3)
    correctAnswerIndex INT NOT NULL,
    -- Nuevo campo para el límite de tiempo de la pregunta
    responseTimeLimit TINYINT DEFAULT 10 COMMENT 'Tiempo límite para responder en segundos'
);

-- 4. CREAR LA TABLA DE HISTORIAL DE JUEGO (game_sessions)
DROP TABLE IF EXISTS game_sessions;
CREATE TABLE game_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    playerName VARCHAR(50) DEFAULT 'Invitado',
    score INT NOT NULL,
    timeTaken INT NOT NULL, -- Tiempo total usado en segundos
    result ENUM('win', 'loss') NOT NULL,
    -- Guardamos el historial de respuestas (qué respondió y si fue correcto)
    answers JSON, 
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. POBLAR LA TABLA DE PREGUNTAS (Datos de ejemplo)
-- Esto permite que el juego funcione inmediatamente después de crear la DB
INSERT INTO questions 
    (category, text, options, correctAnswerIndex, responseTimeLimit) 
VALUES 
('Historia', '¿En qué año llegó el hombre a la Luna?', 
 '["1969", "1965", "1972", "1959"]', 0, 10),

('Ciencia', '¿Cuál es el planeta más grande de nuestro sistema solar?', 
 '["Tierra", "Júpiter", "Saturno", "Marte"]', 1, 8), -- Respuesta rápida, 8s

('Videojuegos', '¿Cómo se llama el fontanero de Nintendo?', 
 '["Luigi", "Wario", "Mario", "Yoshi"]', 2, 12), -- Más tiempo, 12s

('Geografía', '¿Cuál es la capital de Japón?', 
 '["Pekín", "Seúl", "Tokio", "Kioto"]', 2, 10),

('Programación', '¿Qué significa "HTML"?', 
 '["HyperText Markup Language", "High-Level Text Machine", "Hyperlink and Text Markup", "Home Tool Markup Language"]', 0, 15), -- Más tiempo para leer la opción

('Ciencia', '¿Cuál es el símbolo químico del oro?', 
 '["Go", "Or", "Au", "Ag"]', 2, 8);