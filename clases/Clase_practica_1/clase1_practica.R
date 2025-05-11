# Metadatos -----------------------------
# fecha: 250510
# autoria: escuela de datos Fundación SOL
# contenido: clase práctica 1
# ---------------------------------------


# Sección 1: tipos de datos básicos en R ----------------------------------

# - numeric (números reales, ej: 2.5, -10, pi)
# - integer (números enteros, ej: 1L, 50L, -2L - la 'L' le dice a R que es un entero)
# - logical (valores booleanos, ej: TRUE, FALSE, T, F)
# - character (texto o cadenas de caracteres, ej: "hola", 'R es genial')
# - complex (números complejos, ej: 2+3i)


# --- Numeric ---
# Los números se asignan a variables usando el operador de asignación '<-' o '='.
# Se recomienda usar '<-' por convención en R.

numero_decimal <- 2.5
print(numero_decimal)
class(numero_decimal)

# Ejemplo de character
numero_decimal_falso <- "2.5"
numero_decimal_falso
class(numero_decimal_falso)

# --- Logical ---

valor_verdadero <- TRUE
valor_falso <- FALSE

class(valor_verdadero)

valor_t <- T
valor_f <- F

class(valor_t)

# --- Factores (Factor) ---
genero <- factor(c("Masculino", "Femenino",
                   "Otro", "Masculino",
                   "Femenino", "Otro"))

class(genero)
levels(genero)

# Character
genero_char <- c("Masculino", "Femenino",
                  "Otro", "Masculino",
                  "Femenino", "Otro")

class(genero_char)
levels(genero_char)

# vector numerico
edades <- c(24, 30, 22, 35, 30, 18)
edades+8

# Coerción 

vector_mixto <- c(10, "hola", TRUE)
class(vector_mixto)
print(vector_mixto)
vector_mixto

# numericos
vector_mixto_char <- c(10, "1", 20)
class(vector_mixto_char)
print(vector_mixto_char)

# coercionar manual a numero
vector_mixto_num <- as.numeric(vector_mixto_char)

class(vector_mixto_num)

# --- Matrices (Matrix) ---
# Una matriz es una colección bidimensional de elementos del MISMO tipo.
# Se crea con la función matrix().
# matrix(data, nrow, ncol, byrow = FALSE)
# data: vector de datos
# nrow: número de filas
# ncol: número de columnas
# byrow: si es TRUE, la matriz se llena por filas, sino por columnas (default)


matriz_numeros <- matrix(c(1,2,3,4,5,6),
                         nrow = 2,
                         ncol = 3,
                         byrow = TRUE)

class(matriz_numeros)
matriz_numeros

# Otra forma de presentación 

datos <- c(1,2,3,4,5,6)
  
matriz_numeros <- matrix(datos,
                         nrow = 3,
                         ncol = 2,
                         byrow = FALSE)

class(matriz_numeros)
matriz_numeros

# Coordenadas [Fila,Columna]
matriz_numeros[2,1]

# --- Data Frames (Data Frame) ---
# Un data frame es la estructura de datos más importante y comúnmente usada en R para análisis.
# Es una tabla bidimensional donde cada columna puede ser de un tipo de dato diferente,
# pero todos los elementos DENTRO de una misma columna deben ser del mismo tipo.
# Todas las columnas deben tener la misma longitud.
# Se puede pensar como una lista de vectores de igual longitud.
# Se crean con la función data.frame().

# Creación de un data frame (más detalle en la Sección 3)

df_personas <- data.frame(
  ID = 1:4,
  Nombre = c("Ana", "Luis", "Eva", "Diego"),
  Edad = c(28, 34, 39, 45),
  Ocupado = c(TRUE, TRUE, FALSE, TRUE)
  
)

class(df_personas)
print(df_personas)
