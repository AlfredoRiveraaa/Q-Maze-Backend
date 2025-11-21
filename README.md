# 🌐 Q-Maze Backend - API de Persistencia y Configuración

Este repositorio contiene el servidor **Node.js (Express)** que proporciona la API REST necesaria para la persistencia de datos (historial de juego y puntuaciones) y la configuración dinámica del videojuego Q-Maze.

## 🛠️ Tecnologías

- **Servidor:** Node.js (Express)
- **Base de Datos:** MySQL
- **Conexión DB:** `mysql2`
- **Gestión de Entorno:** `dotenv`

---

## 🚀 Instalación y Arranque Rápido

1. **Instalar dependencias:**
    ```bash
    npm install
    ```
2. **Configurar `.env`** (ver sección 3).
3. **Asegurar MySQL:** Verifica que tu servicio de MySQL (XAMPP/WAMP) esté corriendo.
4. **Ejecutar en modo desarrollo** (corre en `http://localhost:3000` por defecto):
    ```bash
    npm run dev
    ```

---

## 3. ⚙️ Configuración del Entorno (`.env`)

Crea un archivo llamado **`.env`** en la raíz del proyecto con tus credenciales de MySQL.  
**ESTE ARCHIVO NO DEBE SUBIRSE A GITHUB.**

```env
# Puerto de la API (DEBE SER DIFERENTE al puerto de Apache, ej: 3000)
PORT=3000

# Credenciales de MySQL
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_contraseña_de_mysql
DB_NAME=qmaze
```

---

## 4. 🗄️ Esquema de la Base de Datos

El backend asume la existencia de la base de datos `qmaze` con las siguientes tablas:

### `questions` (Preguntas de Trivia)

Esta tabla almacena las preguntas que el juego consumirá.

| Columna | Tipo | Descripción |
|--------|------|-------------|
| `id` | `INT` | Clave primaria. |
| `text` | `VARCHAR` | Texto de la pregunta (lo que se muestra en pantalla). |
| `options` | `JSON` | Array de 4 opciones de respuesta. |
| `correctAnswerIndex` | `INT` | Índice de la opción correcta (0, 1, 2, 3). |
| `responseTimeLimit` | `TINYINT` | Tiempo límite para responder (default: 10s). |

### `game_sessions` (Historial de Partidas)

Esta tabla guarda el registro completo de las partidas terminadas.

| Columna | Tipo | Descripción |
|--------|------|-------------|
| `playerName` | `VARCHAR` | Nombre del jugador. |
| `score` | `INT` | Puntuación final. |
| `timeTaken` | `INT` | Tiempo total usado (segundos). |
| `result` | `ENUM` | Resultado: `win` o `loss`. |
| `answers` | `JSON` | Historial de respuestas. |

---

## 5. 🎯 Endpoints de la API

La API responde en la ruta base:  
**`http://localhost:3000/api`**

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/api/config` | Devuelve la configuración dinámica del juego. |
| `GET` | `/api/questions` | Devuelve un set de **15 preguntas aleatorias**. |
| `GET` | `/api/scores` | Devuelve el Top 10 de puntuaciones. |
| `POST` | `/api/game/session` | Guarda el historial de la partida. |

---
