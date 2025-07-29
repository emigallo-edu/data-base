CREATE DATABASE[LigaLibre]
ON PRIMARY(
    NAME = 'LigaLibre_Data',
    FILENAME = '[path]\LigaLibre.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON(
    NAME = 'LigaLibre_Log',
    FILENAME = '[path]\LigaLibre.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
);


DROP DATABASE [LigaLibre]


-- Creación de tablas
CREATE TABLE Clubs (
    Id INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Players (
    Id INT PRIMARY KEY,
    Name VARCHAR(100),
    Edad INT,
    ClubId INT FOREIGN KEY REFERENCES Clubs(Id)
);

-- INSERTS para Club
INSERT INTO Clubs (Id, Name, City) VALUES
(1, 'Boca Juniors', 'Buenos Aires'),
(2, 'River Plate', 'Buenos Aires'),
(3, 'Rosario Central', 'Rosario'),
(4, 'Newell''s Old Boys', 'Rosario'),
(5, 'Independiente', 'Avellaneda');

-- INSERTS para Player
INSERT INTO Players (Id, Name, Edad, ClubId) VALUES
(1, 'Juan Pérez', 22, 1),
(2, 'Carlos Gómez', 25, 1),
(3, 'Martín Ríos', 19, 2),
(4, 'Pedro Sánchez', 30, 2),
(5, 'Lucas Fernández', 28, 3),
(6, 'Franco García', 21, 3),
(7, 'Tomás Benítez', 24, 4),
(8, 'Nicolás Ruiz', 27, 4),
(9, 'Santiago López', 23, 5),
(10, 'Emiliano Acosta', 26, 5);



-- 1. Listar todos los jugadores
SELECT * FROM Players;

-- 2. Listar los jugadores mayores de 25 años
SELECT * FROM Players WHERE Edad > 25;

-- 3. Listar los Names de los clubes y la cantidad de jugadores que tiene cada uno
SELECT c.Name, COUNT(p.Id) AS CantidadJugadores
FROM Club c
LEFT JOIN Players p ON c.Id = p.ClubId
GROUP BY c.Name;

-- 4. Listar los jugadores junto con el Name del club al que pertenecen
SELECT p.Name AS Jugador, c.Name AS Club
FROM Players p
JOIN Club c ON p.ClubId = c.Id;

-- 5. Mostrar los jugadores ordenados por edad descendente
SELECT * FROM Player ORDER BY Edad DESC;

-- 6. Listar los jugadores que pertenecen a clubes de Rosario
SELECT p.Name
FROM Player p
JOIN Club c ON p.ClubId = c.Id
WHERE c.City = 'Rosario';

-- 7. Promedio de edad de jugadores por club
SELECT c.Name, AVG(p.Edad) AS PromedioEdad
FROM Club c
JOIN Player p ON c.Id = p.ClubId
GROUP BY c.Name;

-- 8. Mostrar los clubes que tienen más de 1 jugador mayor de 25 años
SELECT c.Name
FROM Club c
JOIN Player p ON c.Id = p.ClubId
WHERE p.Edad > 25
GROUP BY c.Name
HAVING COUNT(p.Id) > 1;