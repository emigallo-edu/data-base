# Base de datos relacionales

## ¿Qué es una base de datos?

Una **base de datos** es un sistema organizado para almacenar, gestionar y recuperar información. Está compuesta por una colección de datos estructurados que pueden consultarse y modificarse mediante un sistema de gestión de base de datos (SGBD).

### Características

- Permite persistencia de datos.
- Soporta consultas complejas para análisis o reportes.
- Asegura integridad y consistencia a través de restricciones (claves primarias, foráneas, etc).
- Permite acceso concurrente y seguro a los datos.

## Paradigma Relacional

El mundo relacional es el paradigma sobre el que se basan los sistemas de gestión de bases de datos relacionales (SGBDR).

### Características principales:

- Modelo tabular: los datos se organizan en tablas (relaciones), con filas (tuplas) y columnas (atributos).
- Integridad referencial mediante claves primarias y foráneas.
- Lenguaje declarativo (SQL).
- Normalización para evitar redundancia.
- Separación entre datos y lógica de negocio.

## Comparación: Paradgima Relacional vs Jerárquico/Objetual

| Característica                     | Mundo Relacional                                     | Mundo Jerárquico/Objetual                            |
|----------------------------------|-----------------------------------------------------|-----------------------------------------------------|
| Unidad base                      | Tabla                                               | Clase                                              |
| Relaciones                       | Por claves foráneas                                 | Composición, asociación, uso                      |
| Acceso a datos                   | Declarativo (SQL)                                   | Imperativo (métodos, navegación)                   |
| Integridad referencial           | Constraints del SGBD                                | Código del sistema                                 |
| Estructura                       | Tablas planas con relaciones                        | Estructura jerárquicas, clases                         |
| Herencia                         | No nativa                                           | Sí, con herencia de clases                         |
| Modelado                         | Entidades y relaciones                              | Clase con atributos y comportamiento                    |

## Tipos de relaciones en bases de datos relacionales

### Uno a Uno (1:1)
Cada registro de una tabla se relaciona con uno y solo uno de otra.

Ejemplo Liga Libre:
- `TOURNAMENT` 1:1 `STANDING`

![](der_1_1.png)

### Uno a Muchos (1:N)
Un registro en A puede relacionarse con muchos en B, pero B solo con uno en A.

Ejemplos:
- `CLUB` 1:N `PLAYER`
- `TOURNAMENT` 1:N `MATCH`
- `STADIUM` 1:N `MATCH`

![](der_1_n.png)

### Muchos a Muchos (N:N    )
A muchos en A les corresponde muchos en B. Se usa tabla intermedia.

Ejemplos:
- `TOURNAMENT` N:M `CLUB` → `TOURNAMENT_CLUB`
- `STANDING` N:M `CLUB` → `STANDING_ENTRY`

![](der_n_n.png)

## DER - Liga Libre

### Clases involucradas:

- Tournament
- Club
- Player
- Match
- Standing
- Stadium

### Relaciones principales:

- `Tournament` tiene múltiples `Match` y `Club`
- `Tournament` tiene un único `Standing`
- `Club` tiene muchos `Player`
- `Match` involucra dos `Club` y se juega en un `Stadium`
- `Standing` contiene posiciones por `Club`

![](der_simplified.png)


## Conexión entre relaciones entre clases y relaciones entre tablas

Hay una relación conceptual entre los tipos de relaciones entre clases (en diseño orientado a objetos) y los tipos de relaciones entre tablas (en el modelo relacional), pero no es una correspondencia uno a uno exacta.

| Relación entre clases | Relación entre tablas  | Explicación                                                            |
| ----------------- | ---------------------- | -------------------------------------------------------------------------- |
| Asociación        | 1:1, 1\:N o N\:M       | Relación genérica. Dependerá de la multiplicidad definida en la asociación |
| Agregación        | 1\:N                   | Relación "todo-parte", donde la parte puede existir sin el todo            |
| Composición       | 1\:N (con dependencia) | Relación "todo-parte" más fuerte, donde la parte **no existe sin el todo** |
| Uso               |                        | Es una relación **temporal o contextual**, no implica una tabla específica |

### Asociación → 1:1, 1:N, N:N

- Puede derivar en cualquier cardinalidad según la multiplicidad.
- Ejemplo: `MATCH --> STADIUM` → muchos partidos en un mismo estadio → **1:N**

### Agregación → 1:N

- El todo posee partes pero no las controla completamente.
- Ejemplo: `TOURNAMENT ◇--> CLUB` → relación **N:N** con tabla intermedia `TOURNAMENT_CLUB`.

### Composición → 1:N con dependencia

- Las partes **no existen sin el todo**.
- Ejemplo: `TOURNAMENT *-- STANDING` → relación **1:1**, donde `STANDING.tournament_id` es también **PK**.

### Uso → no se modela directamente

- Relación temporal para utilizar métodos o datos.
- No se refleja directamente en la base de datos relacional.


El tipo de relación entre clases orienta la cardinalidad entre tablas, pero no la determina automáticamente.