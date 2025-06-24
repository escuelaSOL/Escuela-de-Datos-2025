# Metadatos -----------------------------
# fecha: 250510
# autoria: escuela de datos Fundación SOL
# contenido: clase práctica 1 - material de estudio
# ---------------------------------------


# --------------------------------------------------------------------------
# Script Introductorio a R
# --------------------------------------------------------------------------
# Este script cubre los fundamentos de R, incluyendo:
# 1. Tipos de Datos Básicos
# 2. Estructuras de Datos (Vectores, Matrices, Listas, Data Frames)
# 3. Creación de Data Frames
# 4. Carga de Datos Externos (ej. CSV)
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------
# Sección 1: Tipos de Datos Básicos en R
# --------------------------------------------------------------------------
# R tiene varios tipos de datos atómicos (los más básicos). Los principales son:
# - numeric (números reales, ej: 2.5, -10, pi)
# - integer (números enteros, ej: 1L, 50L, -2L - la 'L' le dice a R que es un entero)
# - logical (valores booleanos, ej: TRUE, FALSE, T, F)
# - character (texto o cadenas de caracteres, ej: "hola", 'R es genial')
# - complex (números complejos, ej: 2+3i)

# --- Numeric ---
# Los números se asignan a variables usando el operador de asignación '<-' o '='.
# Se recomienda usar '<-' por convención en R.
numero_decimal <- 10.5
print(numero_decimal) # Muestra el valor de la variable
class(numero_decimal) # Muestra el tipo de dato de la variable ("numeric")

# --- Integer ---
# Para crear un entero explícitamente, se añade una 'L' al final del número.
numero_entero <- 25L
print(numero_entero)
class(numero_entero) # Muestra "integer"

# Si no se usa 'L', R por defecto lo trata como 'numeric' aunque sea un entero.
otro_entero <- 30
class(otro_entero) # Muestra "numeric"

# --- Logical ---
valor_verdadero <- TRUE
valor_falso <- FALSE
print(valor_verdadero)
class(valor_falso) # Muestra "logical"

# También se pueden usar T y F (aunque se recomienda TRUE y FALSE para mayor claridad)
valor_t <- T
class(valor_t)

# --- Character ---
texto_saludo <- "Hola, mundo R!"
print(texto_saludo)
class(texto_saludo) # Muestra "character"

otro_texto <- 'R es poderoso' # Se pueden usar comillas simples o dobles
print(otro_texto)

# --- Complex ---
numero_complejo <- 3 + 2i
print(numero_complejo)
class(numero_complejo) # Muestra "complex"

# --- Factores (Factor) ---
# Los factores son un tipo de dato especial para variables categóricas.
# Se crean con la función factor().
genero <- factor(c("Masculino", "Femenino", "Masculino", "Femenino", "Otro"))
print(genero)
class(genero) # Muestra "factor"
levels(genero) # Muestra los niveles o categorías únicas

# --------------------------------------------------------------------------
# Sección 2: Estructuras de Datos en R
# --------------------------------------------------------------------------
# R tiene varias estructuras para almacenar colecciones de datos.
# Las más comunes son: Vectores, Matrices, Arrays, Listas y Data Frames.

# --- Vectores (Vectors) ---
# Un vector es una secuencia ordenada de elementos del MISMO tipo.
# Se crean con la función c() (concatenar o combinar).

# Vector numérico
edades <- c(25, 30, 22, 45, 30)
print(edades)
class(edades) # "numeric" (si todos son numéricos) o "integer" (si todos son enteros con L)

# Vector de caracteres
nombres <- c("Ana", "Luis", "Carlos", "Sofía")
print(nombres)
class(nombres) # "character"

# Vector lógico
respuestas <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
print(respuestas)
class(respuestas) # "logical"

# Si se mezclan tipos, R intentará "coercionar" (convertir) los elementos
# al tipo más general. Por ejemplo, numérico + caracter = caracter.
vector_mixto <- c(10, "Hola", TRUE)
print(vector_mixto) # "10", "Hola", "TRUE"
class(vector_mixto) # "character"

# Acceder a elementos de un vector (indexación empieza en 1)
print(nombres[1])      # Primer elemento: "Ana"
print(edades[2:4])   # Elementos del 2 al 4: 30 22 45
print(edades[c(1, 4)]) # Elementos 1 y 4: 25 45

# Operaciones vectorizadas (se aplican a cada elemento)
numeros <- c(1, 2, 3, 4, 5)
numeros_por_dos <- numeros * 2
print(numeros_por_dos) # 2  4  6  8 10

# --- Matrices (Matrix) ---
# Una matriz es una colección bidimensional de elementos del MISMO tipo.
# Se crea con la función matrix().
# matrix(data, nrow, ncol, byrow = FALSE)
# data: vector de datos
# nrow: número de filas
# ncol: número de columnas
# byrow: si es TRUE, la matriz se llena por filas, sino por columnas (default)

matriz_numeros <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3)
print(matriz_numeros)
#      [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6

matriz_letras <- matrix(c("a", "b", "c", "d", "e", "f"), nrow = 3, ncol = 2, byrow = TRUE)
print(matriz_letras)
#      [,1] [,2]
# [1,] "a"  "b"
# [2,] "c"  "d"
# [3,] "e"  "f"

# Acceder a elementos de una matriz: matriz[fila, columna]
print(matriz_numeros[1, 2]) # Elemento en fila 1, columna 2: 3
print(matriz_numeros[1, ])  # Toda la fila 1
print(matriz_numeros[, 3])  # Toda la columna 3

# --- Arrays (Array) ---
# Un array es similar a una matriz pero puede tener más de dos dimensiones.
# Se crea con la función array().
# array(data, dim)
# data: vector de datos
# dim: vector con las dimensiones

mi_array <- array(1:24, dim = c(3, 4, 2)) # 3 filas, 4 columnas, 2 "capas"
print(mi_array)
# Acceder a elementos: mi_array[fila, columna, capa]
print(mi_array[1, 2, 1]) # Elemento en fila 1, columna 2, capa 1

# --- Listas (List) ---
# Una lista es una colección ordenada de elementos que pueden ser de DIFERENTES tipos.
# Los elementos de una lista pueden ser vectores, matrices, otras listas, etc.
# Se crean con la función list().

mi_lista <- list(
  nombre = "Juan Perez",
  edad = 30L,
  es_estudiante = FALSE,
  notas = c(8.5, 9.0, 7.8),
  info_extra = list(ciudad = "Madrid", telefono = "123456789")
)
print(mi_lista)

# Acceder a elementos de una lista:
# Usando el operador '$' y el nombre del elemento (si tiene nombre)
print(mi_lista$nombre)    # "Juan Perez"
print(mi_lista$notas)     # 8.5 9.0 7.8

# Usando doble corchete '[[]]' con el índice numérico o el nombre
print(mi_lista[[1]])      # "Juan Perez" (primer elemento)
print(mi_lista[["edad"]]) # 30

# Para acceder a un elemento DENTRO de un componente de la lista:
print(mi_lista$notas[2])        # 9.0 (segunda nota)
print(mi_lista$info_extra$ciudad) # "Madrid"
print(mi_lista[[4]][2])         # 9.0 (segundo elemento del cuarto componente de la lista)

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
  Nombre = c("Ana", "Luis", "Eva", "Juan"),
  Edad = c(28, 34, 29, 45),
  Ciudad = c("Lima", "Bogotá", "Quito", "Santiago"),
  Trabaja = c(TRUE, TRUE, FALSE, TRUE)
)
print(df_personas)
class(df_personas) # "data.frame"

# Explorar un data frame:
head(df_personas)    # Muestra las primeras 6 filas (por defecto)
head(df_personas, n = 2) # Muestra las primeras 2 filas
tail(df_personas)    # Muestra las últimas 6 filas
str(df_personas)     # Muestra la estructura del data frame (tipos de datos, etc.)
summary(df_personas) # Proporciona un resumen estadístico de cada columna
dim(df_personas)     # Dimensiones (filas, columnas)
nrow(df_personas)    # Número de filas
ncol(df_personas)    # Número de columnas
names(df_personas)   # Nombres de las columnas (también colnames())
rownames(df_personas) # Nombres de las filas (por defecto son números)

# Acceder a elementos de un data frame:
# Similar a las matrices y listas.

# Como una lista (usando '$' o '[[]]' para columnas):
print(df_personas$Nombre)      # Columna 'Nombre' como vector
print(df_personas[["Edad"]])   # Columna 'Edad' como vector

# Como una matriz (usando '[]' con [fila, columna]):
print(df_personas[1, 2])       # Elemento en fila 1, columna 2: "Ana"
print(df_personas[1, "Nombre"]) # Mismo resultado: "Ana"

print(df_personas[1, ])        # Toda la fila 1 (devuelve un data frame de 1 fila)
print(df_personas[, "Ciudad"]) # Toda la columna 'Ciudad' (devuelve un vector)
print(df_personas[, c("Nombre", "Edad")]) # Varias columnas (devuelve un data frame)

# Filtrar filas basadas en condiciones:
# Personas mayores de 30 años
mayores_30 <- df_personas[df_personas$Edad > 30, ]
print(mayores_30)

# Personas de Lima
personas_lima <- df_personas[df_personas$Ciudad == "Lima", ]
print(personas_lima)

# --------------------------------------------------------------------------
# Sección 3: Creación de Data Frames con Código
# --------------------------------------------------------------------------
# Ya vimos un ejemplo básico. Aquí profundizamos un poco más.

# Método 1: Usando vectores para cada columna
ids_productos <- c("P001", "P002", "P003", "P004")
nombres_productos <- c("Laptop", "Mouse", "Teclado", "Monitor")
precios_unitarios <- c(1200.50, 25.99, 75.00, 300.75)
stock_disponible <- c(15L, 150L, 75L, 30L) # Enteros

inventario_df <- data.frame(
  Codigo = ids_productos,
  Producto = nombres_productos,
  Precio = precios_unitarios,
  Stock = stock_disponible
)
print(inventario_df)
str(inventario_df)

# Importante: Por defecto, data.frame() convierte las columnas de caracteres
# en factores. Esto era común en versiones antiguas de R.
# En R 4.0.0 y posteriores, el comportamiento por defecto es NO convertir
# caracteres a factores (stringsAsFactors = FALSE).
# Si usas una versión anterior de R, o quieres asegurarte:
inventario_df_sin_factores <- data.frame(
  Codigo = ids_productos,
  Producto = nombres_productos,
  Precio = precios_unitarios,
  Stock = stock_disponible,
  stringsAsFactors = FALSE # Evita que las columnas de texto se conviertan a factores
)
str(inventario_df_sin_factores) # Observa la clase de 'Codigo' y 'Producto'

# Método 2: Creando un data frame vacío y luego añadiendo filas/columnas
# (generalmente menos eficiente para data frames grandes que crearlo de una vez)

# Crear un data frame vacío con columnas definidas
df_vacio <- data.frame(
  Nombre = character(),
  Edad = integer(),
  Puntaje = numeric()
)
print(df_vacio)
str(df_vacio)

# Añadir filas (usando rbind - row bind)
nueva_fila1 <- list(Nombre = "Carlos", Edad = 22L, Puntaje = 88.5)
df_vacio <- rbind(df_vacio, nueva_fila1)
print(df_vacio)

nueva_fila2 <- data.frame(Nombre = "Laura", Edad = 25L, Puntaje = 92.1) # También puede ser un df
df_vacio <- rbind(df_vacio, nueva_fila2)
print(df_vacio)

# Añadir columnas (usando cbind - column bind o asignación directa)
ciudades_origen <- c("México", "Colombia")
df_vacio <- cbind(df_vacio, Ciudad = ciudades_origen) # cbind requiere misma long de filas
print(df_vacio)

# O asignación directa (más común y flexible)
df_vacio$Pais <- c("MX", "CO")
print(df_vacio)
str(df_vacio)

# --------------------------------------------------------------------------
# Sección 4: Carga de Planillas (Archivos Externos)
# --------------------------------------------------------------------------
# R puede leer datos de una gran variedad de formatos de archivo.
# Los más comunes son CSV (Comma Separated Values) y archivos de Excel.

# --- Cargar archivos CSV ---
# La función principal es read.csv() o read.csv2() (para CSVs con ';' como separador y ',' como decimal).

# Antes de cargar, necesitas saber dónde está tu archivo.
# Puedes usar la ruta completa al archivo o establecer tu directorio de trabajo.

# Opción 1: Usar la ruta completa
# Supongamos que tienes un archivo llamado "datos_ventas.csv" en "C:/MisDocumentos/DatosR/"
# (En Windows, las barras invertidas '\' deben escaparse como '\\' o usar '/')
# ruta_archivo_csv <- "C:/MisDocumentos/DatosR/datos_ventas.csv"
# ventas_df <- read.csv(ruta_archivo_csv)

# Opción 2: Establecer el directorio de trabajo
# getwd() # Muestra el directorio de trabajo actual
# setwd("C:/MisDocumentos/DatosR/") # Cambia el directorio de trabajo
# Una vez en el directorio correcto:
# ventas_df <- read.csv("datos_ventas.csv")

# Para este script, vamos a crear un archivo CSV de ejemplo para poder leerlo.
# Si estás ejecutando este script, se creará un archivo 'ejemplo_data.csv'
# en tu directorio de trabajo actual.

# Crear datos de ejemplo para el CSV
datos_para_csv <- data.frame(
  ID_Cliente = paste0("C", 101:105), # Crea C101, C102, ...
  Producto_Comprado = c("Libro", "Tablet", "Audifonos", "Libro", "Software"),
  Monto_Gastado = c(25.50, 250.00, 79.99, 19.95, 120.00),
  Fecha_Compra = as.Date(c("2023-01-15", "2023-01-20", "2023-02-01", "2023-02-05", "2023-02-10"))
)

# Escribir el data frame a un archivo CSV
# La función write.csv() guarda el data frame.
# row.names = FALSE evita que se escriba una columna extra con los números de fila de R.
write.csv(datos_para_csv, "ejemplo_data.csv", row.names = FALSE)
print("Archivo 'ejemplo_data.csv' creado en el directorio de trabajo.")

# Ahora, leemos el archivo CSV que acabamos de crear
datos_cargados_csv <- read.csv("ejemplo_data.csv")

# Verificamos los datos cargados
print("Datos cargados desde 'ejemplo_data.csv':")
print(datos_cargados_csv)
str(datos_cargados_csv) # Observa los tipos de datos. 'Fecha_Compra' puede ser caracter.

# read.csv tiene muchos argumentos útiles:
# header = TRUE (default): Indica si la primera fila contiene los nombres de las columnas.
# sep = "," (default): El carácter separador de campos. Para CSVs europeos usar ';'.
# dec = "." (default): El carácter decimal. Para CSVs europeos usar ','.
# stringsAsFactors = FALSE (default en R >= 4.0): Controla si las cadenas se leen como factores.
# na.strings = "NA": Especifica qué cadenas en el archivo deben interpretarse como NA (datos faltantes).

# Ejemplo: si el CSV usa ';' como separador y ',' para decimales (común en Europa)
# Y queremos que las cadenas de texto sigan siendo texto:
# datos_cargados_csv2 <- read.csv2("otro_ejemplo.csv", stringsAsFactors = FALSE)
# read.csv2 es un atajo para read.csv(file, header = TRUE, sep = ";", dec = ",", ...)

# Si la columna de fecha se leyó como caracter, podemos convertirla:
# (En este caso, write.csv y read.csv suelen manejar bien las fechas si ya son tipo Date)
# Si 'Fecha_Compra' fuera caracter:
# datos_cargados_csv$Fecha_Compra <- as.Date(datos_cargados_csv$Fecha_Compra, format = "%Y-%m-%d")
# str(datos_cargados_csv) # Verificar de nuevo

# --- Cargar archivos de Excel (.xls, .xlsx) ---
# Para archivos de Excel, necesitas instalar y cargar un paquete adicional.
# El paquete más común y recomendado es 'readxl'.

# Primero, instala el paquete si no lo tienes (solo necesitas hacerlo una vez):
# install.packages("readxl")

# Luego, carga el paquete en tu sesión de R (cada vez que inicies R y lo necesites):
# library(readxl)

# Supongamos que tienes un archivo "datos_excel.xlsx"
# ruta_archivo_excel <- "C:/MisDocumentos/DatosR/datos_excel.xlsx"

# Leer una hoja específica de Excel:
# datos_excel_df <- read_excel(ruta_archivo_excel, sheet = "Hoja1") # O el nombre de la hoja
# datos_excel_df <- read_excel(ruta_archivo_excel, sheet = 1)     # O el índice de la hoja

# Para este script, no crearemos un archivo Excel, pero así es como lo harías.
# print(datos_excel_df)
# str(datos_excel_df)

# Otros paquetes útiles para leer datos:
# - 'data.table': para leer archivos grandes muy rápidamente (función fread()).
#   install.packages("data.table")
#   library(data.table)
#   datos_rapidos <- fread("archivo_grande.csv")
# - 'haven': para leer archivos de otros software estadísticos (SPSS, Stata, SAS).
#   install.packages("haven")
#   library(haven)
#   datos_spss <- read_sav("archivo.sav")
# - 'jsonlite': para leer archivos JSON.
#   install.packages("jsonlite")
#   library(jsonlite)
#   datos_json <- fromJSON("archivo.json")

# --------------------------------------------------------------------------
# ¡Fin del Script Introductorio!
# --------------------------------------------------------------------------
# Consejos adicionales:
# - Usa el panel de Ayuda en RStudio: ?nombre_de_funcion (ej: ?data.frame)
# - Practica mucho: la programación se aprende haciendo.
# - Explora conjuntos de datos integrados en R: data() muestra la lista.
#   Ejemplo: head(iris), str(mtcars)
# - Busca en internet: Stack Overflow es un gran recurso para dudas de R.
# --------------------------------------------------------------------------
