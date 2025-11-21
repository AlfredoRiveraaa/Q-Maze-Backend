-- qmaze_schema.sql
-- Script para crear la base de datos, tablas y poblar con 100 preguntas educativas
-- para el backend del juego Q-Maze.
-- 
-- INSTRUCCIONES DE EJECUCIÓN:
-- 1. Asegúrate de que tu servicio MySQL esté activo.
-- 2. Ejecuta este script en tu gestor de base de datos (phpMyAdmin, Workbench, etc.).

-- 1. SE CREA LA BASE DE DATOS
-- Usamos IF NOT EXISTS para evitar errores si ya existe
CREATE DATABASE IF NOT EXISTS qmaze;

-- 2. SELECCIONAMOS LA BASE DE DATOS
USE qmaze;

-- 3. ELIMINAMOS TABLAS EXISTENTES (Para limpieza y re-ejecución)
DROP TABLE IF EXISTS game_sessions;
DROP TABLE IF EXISTS questions;

-- 4. CREAMOS LA TABLA DE PREGUNTAS (questions)
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100) DEFAULT 'General',
    text VARCHAR(255) NOT NULL,
    -- Array JSON con las 4 opciones de respuesta
    options JSON NOT NULL, 
    -- Índice de la respuesta correcta (0=A, 1=B, 2=C, 3=D)
    correctAnswerIndex INT NOT NULL,
    -- Tiempo límite para responder, dinámico por pregunta
    responseTimeLimit TINYINT DEFAULT 10 COMMENT 'Tiempo límite para responder en segundos'
);

-- 5. CREAMOS LA TABLA DE HISTORIAL DE JUEGO (game_sessions)
CREATE TABLE game_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    playerName VARCHAR(50) DEFAULT 'Invitado',
    score INT NOT NULL,
    timeTaken INT NOT NULL, -- Tiempo total usado en segundos
    result ENUM('win', 'loss') NOT NULL,
    -- Array JSON con el historial detallado de respuestas dadas
    answers JSON, 
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. POBLAMOS LA TABLA DE PREGUNTAS
INSERT INTO questions 
    (category, text, options, correctAnswerIndex, responseTimeLimit) 
VALUES 
-- *****************************************************************
-- I. CIENCIAS NATURALES Y QUÍMICA (25 Preguntas)
-- *****************************************************************
('Ciencia', '¿Cuál es el proceso por el cual las plantas crean su propio alimento?', '["Respiración celular", "Transpiración", "Fotosíntesis", "Fermentación"]', 2, 10),
('Ciencia', '¿Cuál es el elemento químico más abundante en la corteza terrestre?', '["Oxígeno", "Silicio", "Aluminio", "Hierro"]', 1, 10),
('Ciencia', '¿Qué instrumento se utiliza para medir la presión atmosférica?', '["Termómetro", "Anemómetro", "Barómetro", "Higrómetro"]', 2, 10),
('Ciencia', '¿Cuál es la unidad básica de la herencia genética?', '["Cromosoma", "Gen", "Proteína", "Célula"]', 1, 8),
('Ciencia', '¿Qué tipo de energía produce la fisión nuclear?', '["Solar", "Química", "Térmica", "Geotérmica"]', 2, 10),
('Ciencia', '¿Cuántos planetas forman parte del sistema solar (excluyendo a Plutón)?', '["7", "8", "9", "10"]', 1, 8),
('Ciencia', '¿Qué gas es indispensable para que ocurra la combustión?', '["Nitrógeno", "Dióxido de carbono", "Argón", "Oxígeno"]', 3, 8),
('Ciencia', '¿Cómo se llama la capa más externa de la Tierra?', '["Manto", "Núcleo", "Corteza", "Astenósfera"]', 2, 8),
('Ciencia', '¿Cuál es el componente principal del aire que respiramos?', '["Oxígeno", "Nitrógeno", "Dióxido de carbono", "Vapor de agua"]', 1, 10),
('Ciencia', '¿A qué grupo de animales pertenece la ballena?', '["Peces", "Reptiles", "Anfibios", "Mamíferos"]', 3, 8),
('Química', '¿Cuál es el símbolo químico del oro?', '["Ag", "Au", "Fe", "Cu"]', 1, 8),
('Química', '¿Qué valor de pH se considera neutro?', '["0", "7", "14", "5"]', 1, 8),
('Química', '¿Qué partículas subatómicas se encuentran en el núcleo de un átomo?', '["Electrones y neutrones", "Protones y electrones", "Protones y neutrones", "Solo protones"]', 2, 10),
('Química', '¿Qué es una molécula?', '["Un átomo muy pequeño", "Dos o más átomos unidos", "Una célula viva", "Un neutrón"]', 1, 10),
('Química', '¿El agua pura conduce la electricidad?', '["Sí, muy bien", "Sí, poco", "No, es aislante", "Solo si está congelada"]', 2, 12),
('Química', '¿Qué es un catalizador?', '["Sustancia que se consume en la reacción", "Sustancia que acelera la reacción", "Producto final de una reacción", "Sustancia que detiene la reacción"]', 1, 15),
('Ciencia', '¿Qué enfermedad es causada por una bacteria?', '["Gripe", "Resfriado común", "Sarampión", "Tuberculosis"]', 3, 12),
('Ciencia', '¿Cuál es la fórmula química del ácido sulfúrico?', '["HCl", "H2SO4", "HNO3", "NaCl"]', 1, 10),
('Ciencia', '¿Cómo se llama la estrella más cercana a la Tierra?', '["Sirio", "Alpha Centauri", "Polaris", "El Sol"]', 3, 8),
('Ciencia', '¿Qué elemento forma el ozono?', '["Nitrógeno", "Carbono", "Oxígeno", "Hidrógeno"]', 2, 10),
('Ciencia', '¿Cuál es la función principal de los glóbulos rojos?', '["Combatir infecciones", "Coagular la sangre", "Transportar oxígeno", "Almacenar grasa"]', 2, 10),
('Ciencia', '¿Qué tipo de roca se forma por el enfriamiento del magma?', '["Sedimentaria", "Metamórfica", "Ígnea", "Caliza"]', 2, 12),
('Química', 'El número atómico ($Z$) de un elemento define el número de:', '["Neutrones", "Masa atómica", "Protones", "Electrones"]', 2, 10),
('Ciencia', '¿Qué hueso protege el cerebro?', '["Columna vertebral", "Costillas", "Fémur", "Cráneo"]', 3, 8),
('Ciencia', '¿Qué mide la escala de Richter?', '["Temperatura", "Velocidad del viento", "Intensidad del sismo", "Humedad"]', 2, 10),

-- *****************************************************************
-- II. HISTORIA Y CULTURA (25 Preguntas)
-- *****************************************************************
('Historia', '¿En qué año cayó el Muro de Berlín?', '["1985", "1991", "1989", "1990"]', 2, 8),
('Historia', '¿Quién fue el primer presidente de los Estados Unidos?', '["Thomas Jefferson", "Abraham Lincoln", "George Washington", "John Adams"]', 2, 10),
('Historia', '¿En qué país se originó la civilización Maya?', '["Perú", "Egipto", "Grecia", "México y Centroamérica"]', 3, 10),
('Historia', '¿Cómo se llama el proceso de intercambio de bienes y cultura que siguió al descubrimiento de América?', '["Ruta de la Seda", "Intercambio Colombino", "Guerra Fría", "Revolución Industrial"]', 1, 15),
('Historia', '¿Qué evento marcó tradicionalmente el inicio de la Edad Media?', '["Caída de Roma (476 d.C.)", "Nacimiento de Jesús", "Descubrimiento de América", "Revolución Francesa"]', 0, 15),
('Historia', '¿Quién pintó la Mona Lisa?', '["Van Gogh", "Picasso", "Leonardo da Vinci", "Miguel Ángel"]', 2, 8),
('Historia', '¿En qué año comenzó la Primera Guerra Mundial?', '["1914", "1918", "1939", "1905"]', 0, 8),
('Historia', '¿Cuál fue el principal invento de Johannes Gutenberg?', '["La máquina de vapor", "El telescopio", "La imprenta de tipos móviles", "La bombilla"]', 2, 10),
('Historia', '¿Qué civilización construyó las pirámides de Giza?', '["Romanos", "Griegos", "Egipcios", "Incas"]', 2, 8),
('Historia', '¿Quién fue el líder de la India que promovió la desobediencia civil no violenta?', '["Jawaharlal Nehru", "Indira Gandhi", "Mahatma Gandhi", "Nelson Mandela"]', 2, 10),
('Historia', '¿Qué monarca fue decapitado durante la Revolución Francesa?', '["Luis XVI", "Luis XIV", "Napoleón", "Carlos I"]', 0, 10),
('Historia', '¿Cuál es el documento que establece que todos los hombres nacen libres e iguales?', '["La Carta Magna", "La Biblia", "La Declaración Universal de Derechos Humanos", "El Manifiesto Comunista"]', 2, 15),
('Historia', '¿Cuál es la ciudad conocida como la Cuna de la Democracia?', '["Roma", "Atenas", "Esparta", "Jerusalén"]', 1, 8),
('Historia', '¿Quién fue el conquistador español que derrotó al Imperio Azteca?', '["Francisco Pizarro", "Hernán Cortés", "Cristóbal Colón", "Vasco Núñez de Balboa"]', 1, 10),
('Historia', '¿Qué gran incendio destruyó gran parte de Londres en 1666?', '["Gran Incendio de Chicago", "Gran Incendio de Roma", "Gran Incendio de Londres", "Incendio de la Biblioteca de Alejandría"]', 2, 12),
('Cultura', '¿Cuál es el deporte nacional de Japón?', '["Fútbol", "Karate", "Sumo", "Béisbol"]', 2, 8),
('Cultura', '¿En qué idioma está escrita la Divina Comedia?', '["Latín", "Español", "Italiano", "Griego"]', 2, 10),
('Cultura', '¿Cuántas cuerdas tiene un violín?', '["3", "4", "5", "6"]', 1, 8),
('Cultura', '¿Qué famoso compositor era sordo?', '["Mozart", "Bach", "Chopin", "Beethoven"]', 3, 8),
('Cultura', '¿Cuál es el título de la obra de teatro más famosa de Shakespeare?', '["Romeo y Julieta", "El Rey Lear", "Hamlet", "Macbeth"]', 2, 10),
('Cultura', '¿Cuál es el libro sagrado del Islam?', '["La Torá", "El Corán", "La Biblia", "El Zend Avesta"]', 1, 10),
('Cultura', '¿Qué tipo de arte creaba Andy Warhol?', '["Impresionismo", "Cubismo", "Pop Art", "Surrealismo"]', 2, 12),
('Historia', '¿Qué fue la Guerra Fría?', '["Conflicto entre Francia e Inglaterra", "Conflicto entre Estados Unidos y la URSS", "Guerra entre Rusia y Japón", "Guerra civil de China"]', 1, 15),
('Historia', '¿Qué significa la palabra Renacimiento?', '["Muerte lenta", "Nuevo Orden", "Re-nacimiento", "Gran Invento"]', 2, 8),
('Historia', '¿Quién fue el dictador de Alemania durante la Segunda Guerra Mundial?', '["Benito Mussolini", "Joseph Stalin", "Adolf Hitler", "Winston Churchill"]', 2, 10),

-- *****************************************************************
-- III. GEOGRAFÍA Y MATEMÁTICAS (25 Preguntas)
-- *****************************************************************
('Geografía', '¿Cuál es el río más largo del mundo?', '["Nilo", "Misisipi", "Amazonas", "Yangtsé"]', 2, 8),
('Geografía', '¿Cuál es el país más grande del mundo por área terrestre?', '["China", "Canadá", "Estados Unidos", "Rusia"]', 3, 8),
('Geografía', '¿En qué continente se encuentra el desierto del Sahara?', '["Asia", "África", "América del Sur", "Oceanía"]', 1, 8),
('Geografía', '¿Cuál es la montaña más alta del mundo?', '["K2", "Monte Fuji", "Monte Everest", "Aconcagua"]', 2, 10),
('Geografía', '¿Cuál es el océano más grande del planeta?', '["Atlántico", "Índico", "Ártico", "Pacífico"]', 3, 8),
('Geografía', '¿Qué estrecho separa Asia de América del Norte?', '["Estrecho de Gibraltar", "Estrecho de Magallanes", "Estrecho de Bering", "Estrecho de Malaca"]', 2, 12),
('Geografía', '¿Cuál es el país con más habitantes del mundo?', '["India", "Estados Unidos", "China", "Indonesia"]', 0, 8),
('Geografía', '¿Cuántos estados forman los Estados Unidos de América?', '["48", "50", "52", "55"]', 1, 8),
('Geografía', '¿Qué país es conocido como la Tierra del Sol Naciente?', '["Corea", "China", "Japón", "Tailandia"]', 2, 8),
('Geografía', '¿Cuál es el paralelo principal que divide la Tierra?', '["Trópico de Cáncer", "Círculo Polar Ártico", "Ecuador", "Meridiano de Greenwich"]', 2, 10),
('Matemáticas', '¿Qué tipo de ángulo mide exactamente $90^{\\circ}$?', '["Agudo", "Obtuso", "Recto", "Llano"]', 2, 8),
('Matemáticas', '¿Cuál es el valor de $\\pi$ (Pi) aproximado a dos decimales?', '["3.12", "3.14", "3.16", "3.18"]', 1, 8),
('Matemáticas', 'En la fórmula $E = mc^2$, ¿qué representa la $E$?', '["Electricidad", "Energía", "Ecuación", "Expansión"]', 1, 10),
('Matemáticas', '¿Cómo se llama la figura geométrica de 12 lados?', '["Decágono", "Octágono", "Dodecágono", "Eneágono"]', 2, 10),
('Matemáticas', '¿Cuál es el resultado de $15 \\times 0 + 5$?', '["0", "5", "15", "20"]', 1, 8),
('Matemáticas', '¿Qué es un número primo?', '["Número divisible por 3", "Número divisible por sí mismo y por 1", "Número par", "Número menor a 10"]', 1, 12),
('Matemáticas', '¿Cómo se llama el resultado de una división?', '["Suma", "Resta", "Cociente", "Producto"]', 2, 8),
('Matemáticas', '¿Qué mide el perímetro de un círculo?', '["El área", "El radio", "La circunferencia", "El diámetro"]', 2, 10),
('Matemáticas', '¿Cuál es el logaritmo en base 10 de 100?', '["1", "2", "10", "100"]', 1, 10),
('Matemáticas', '¿Qué propiedad matemática establece que $a \\times (b + c) = a \\times b + a \\times c$?', '["Conmutativa", "Asociativa", "Distributiva", "Identidad"]', 2, 15),
('Geografía', '¿Cuál es el punto más bajo de la Tierra en tierra firme?', '["El Mar Caspio", "El Desierto de Atacama", "El Mar Muerto", "El Lago Baikal"]', 2, 12),
('Geografía', '¿Qué país tiene la mayor cantidad de husos horarios?', '["China", "Estados Unidos", "Rusia", "Francia"]', 3, 10),
('Geografía', '¿Cuál es el único continente sin hormigas nativas?', '["Oceanía", "Antártida", "África", "Asia"]', 1, 10),
('Matemáticas', '¿Cuántos milímetros hay en un metro?', '["10", "100", "1000", "10000"]', 2, 8),
('Matemáticas', '¿Qué representa el número 0 en la recta numérica?', '["Valor negativo", "Valor positivo", "El origen", "El infinito"]', 2, 8),

-- *****************************************************************
-- IV. LENGUAJE, LÓGICA Y TECNOLOGÍA (25 Preguntas)
-- *****************************************************************
('Lenguaje', '¿Qué parte de la oración es la que nombra a personas, animales o cosas?', '["Verbo", "Adjetivo", "Sustantivo", "Adverbio"]', 2, 10),
('Lenguaje', '¿Qué es un sinónimo?', '["Palabra con significado opuesto", "Palabra con significado igual o similar", "Palabra que rima", "Palabra polisémica"]', 1, 8),
('Lenguaje', '¿Cuál es el plural de la palabra crisis?', '["Crisis", "Crisises", "Crisi", "Crisias"]', 0, 10),
('Lenguaje', '¿Cómo se llama el signo de puntuación que indica una pausa breve?', '["Punto final", "Punto y coma", "Coma", "Dos puntos"]', 2, 8),
('Lenguaje', '¿Qué tipo de palabra modifica a un verbo, un adjetivo o a otro adverbio?', '["Sustantivo", "Adjetivo", "Preposición", "Adverbio"]', 3, 12),
('Lenguaje', '¿Quién es el autor de El Principito?', '["Julio Cortázar", "Gabriel García Márquez", "Antoine de Saint-Exupéry", "Jorge Luis Borges"]', 2, 10),
('Lenguaje', '¿Qué son las palabras homófonas?', '["Palabras que se escriben igual", "Palabras que suenan igual pero se escriben diferente", "Palabras que tienen significado opuesto", "Palabras que tienen más de un significado"]', 1, 15),
('Lenguaje', '¿Qué tiempo verbal se utiliza para hablar de una acción que ocurrirá en el futuro?', '["Presente", "Pasado", "Condicional", "Futuro"]', 3, 8),
('Lenguaje', '¿Cuál es la función principal de la introducción en un texto?', '["Desarrollar argumentos", "Concluir el tema", "Presentar el tema y captar interés", "Citar fuentes"]', 2, 10),
('Tecnología', '¿Qué significa URL?', '["Universal Resource Location", "Uniform Resource Locator", "Ultimate Resource Link", "User Request Line"]', 1, 10),
('Tecnología', '¿Cuál es el componente de una computadora que ejecuta las instrucciones de un programa?', '["Memoria RAM", "Disco Duro", "Tarjeta Gráfica", "CPU"]', 3, 8),
('Tecnología', '¿Qué protocolo se utiliza para navegar en la web?', '["FTP", "SMTP", "HTTP", "TCP"]', 2, 8),
('Tecnología', '¿Qué lenguaje se utiliza para definir la estructura de una página web?', '["CSS", "JavaScript", "Python", "HTML"]', 3, 8),
('Tecnología', '¿Cuál es el término para un programa malicioso que se autorreplica?', '["Gusano", "Troyano", "Spyware", "Ransomware"]', 0, 10),
('Lógica', 'Si todos los A son B, y todos los B son C, ¿qué conclusión es válida?', '["Todos los C son A", "Algunos A no son C", "Todos los A son C", "Ningún A es C"]', 2, 15),
('Lógica', 'Si la afirmación El cielo es azul es verdadera, ¿qué es la negación El cielo no es azul?', '["Verdadera", "Falsa", "Irrelevante", "Contradictoria"]', 1, 8),
('Lógica', '¿Qué es una falacia?', '["Una verdad innegable", "Un error de razonamiento lógico", "Una premisa inválida", "Una deducción correcta"]', 1, 12),
('Tecnología', '¿Qué es la computación en la nube?', '["Usar una computadora con Wi-Fi", "Almacenamiento y servicios por internet", "El software de la computadora", "Un tipo de disco duro"]', 1, 10),
('Lenguaje', '¿Cuál es el acento que no se escribe, pero se pronuncia?', '["Diacrítico", "Prosódico", "Ortográfico", "Esdrújulo"]', 1, 12),
('Lenguaje', '¿Qué figura literaria utiliza la exageración de cualidades o acciones?', '["Metáfora", "Símil", "Hipérbole", "Personificación"]', 2, 15),
('Tecnología', '¿Qué unidad de medida se usa para la frecuencia de un procesador?', '["Byte", "Voltio", "Hertz (Hz)", "Amperio"]', 2, 8),
('Tecnología', '¿Qué significa IP en términos de red?', '["Internet Protocol", "Information Packet", "Internal Port", "Input Process"]', 0, 8),
('Lógica', 'Si un evento siempre ocurre antes que otro, ¿cuál es la relación?', '["Casualidad", "Simultaneidad", "Causalidad", "Independencia"]', 2, 12),
('Lenguaje', '¿Qué es un diptongo?', '["Dos vocales fuertes seguidas", "Dos vocales débiles seguidas", "Una vocal fuerte y una débil en la misma sílaba", "Tres vocales seguidas"]', 2, 10),
('Lógica', 'El razonamiento que va de lo general a lo particular es:', '["Inducción", "Deducción", "Analogía", "Abducción"]', 1, 10);