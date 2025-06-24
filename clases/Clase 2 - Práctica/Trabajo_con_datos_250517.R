<<<<<<< HEAD
#-----------------------------------------------------------------------------#
# Script de R: Trabajo con Datos en R - Clase práctica 2                      #
# Foco: R base, Bucles (loops) y Creación/Aplicación de Funciones Eficientes #
# Trabajando con base Gapminder y Estructuras de Control                    #
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
# Sección 0: Introducción y Preparación del Entorno con R base                           #
#-----------------------------------------------------------------------------#

# R base se refiere a las funciones que vienen con la instalación estándar de R,
# sin necesidad de cargar paquetes adicionales para muchas tareas fundamentales.

cat("--- 0.1 Comandos básicos de salida: print() vs cat() ---\n")
# 'print()' es una función genérica que muestra objetos R.
# Es útil para inspeccionar el contenido de variables, vectores, data frames, etc.
# Generalmente añade metadatos como índices o niveles de factores.
un_vector <- c("a", "b", "c")
cat("Usando print() para un_vector:\n")
print(un_vector)

un_numero <- 10
cat("\nUsando print() para un_numero:\n")
print(un_numero)

# 'cat()' se usa para concatenar y mostrar salidas, ofreciendo más control sobre el formato.
# No añade metadatos por defecto y es bueno para crear mensajes o salidas formateadas.
# Necesita saltos de línea explícitos (\n).
cat("\nUsando cat() para un_vector y un_numero:\n")
cat("El vector es:", un_vector, "y el número es:", un_numero, "\n")
cat("Podemos concatenar múltiples elementos:", "Elemento1", 2, "Elemento3", "\n")
# A lo largo de este script, usaremos 'cat()' para mensajes explicativos
# y 'print()' para mostrar la estructura o contenido de objetos de datos.

cat("\n--- 0.2 Estructuras de Control Condicional ---\n")
# Las estructuras de control condicional permiten ejecutar diferentes bloques de código
# según se cumplan o no ciertas condiciones.

# if, else if, else
cat("\nEjemplo de if, else if, else:\n")
x <- 5  # Asigna el valor 5 a la variable 'x'.  Este es el valor que vamos a evaluar.

# Estructura de control 'if-else' anidada para evaluar el valor de 'x'.
# La estructura 'if-else' permite ejecutar diferentes bloques de código
# dependiendo de si una condición es verdadera o falsa.

if (x > 10) {
  # Si la condición 'x > 10' es VERDADERA, se ejecuta este bloque de código.
  cat("x es mayor que 10\n") # Imprime en la consola que 'x' es mayor que 10.
} else if (x > 0 && x <= 10) {
  # Si la condición anterior es FALSA, se evalúa esta condición.
  # La condición 'x > 0 && x <= 10' verifica si 'x' está entre 1 y 10 (inclusive).
  # '&&' es el operador lógico "y" (AND). Ambas subcondiciones deben ser verdaderas.
  cat("x es positivo y menor o igual a 10\n") # Imprime el mensaje correspondiente.
} else if (x == 0) {
  # Si las condiciones anteriores son FALSAS, se evalúa esta condición.
  # La condición 'x == 0' verifica si 'x' es igual a 0.
  # '==' es el operador de igualdad.
  cat("x es cero\n") # Imprime que 'x' es cero.
} else {
  # Si ninguna de las condiciones anteriores es VERDADERA, se ejecuta este bloque 'else'.
  # El bloque 'else' se ejecuta por defecto cuando ninguna de las condiciones 'if' o 'else if' se cumple.
  cat("x es negativo\n") # Imprime que 'x' es negativo.
}

y <- -3
if (y > 0) {
  cat("y (", y, ") es positivo.\n", sep="")
} else {
  cat("y (", y, ") no es positivo (es cero o negativo).\n", sep="")
}

# ifelse()
# Es una forma vectorizada de if-else.
# Sintaxis: ifelse(condicion, valor_si_verdadero, valor_si_falso)
cat("\nEjemplo de ifelse():\n")
numeros <- -3:3
resultado_ifelse <- ifelse(numeros > 0, "Positivo", "No Positivo")
print(data.frame(Numero = numeros, Clasificacion = resultado_ifelse))

# Ejemplo: Asignar 'grande' o 'pequeño' basado en un umbral
valores <- c(1, 5, 10, 15, 2, 8)
umbral <- 7
clasificacion_tamano <- ifelse(valores > umbral, "Grande", "Pequeño")
print(data.frame(Valor = valores, Tamano = clasificacion_tamano))


cat("\n--- 0.3 Preparando el Dataset de Ejemplo ---\n")
# Usaremos el dataset 'iris' para ejemplos básicos y el paquete 'gapminder' para ejemplos más aplicados.

# Dataset 'iris' (incorporado en R)
data(iris)
cat("--- Vista Previa del Dataset 'iris' ---\n")
print(head(iris))
cat("\n--- Estructura del Dataset 'iris' ---\n")
print(str(iris))

# Dataset 'gapminder'
# Primero, verificamos si el paquete está instalado. Si no, lo instalamos.
if (!requireNamespace("gapminder", quietly = TRUE)) {
  cat("Instalando el paquete 'gapminder'...\n")
  install.packages("gapminder")
}

library(gapminder) # Cargamos el paquete

cat("\n\n--- Vista Previa del Dataset 'gapminder' ---\n")
print(head(gapminder))
cat("\n--- Estructura del Dataset 'gapminder' ---\n")
print(str(gapminder))
cat("\n--- Resumen Estadístico del Dataset 'gapminder' ---\n")
# Mostraremos un resumen de las primeras columnas para brevedad
print(summary(gapminder[, c("country", "continent", "year", "lifeExp")]))


#-----------------------------------------------------------------------------#
# Sección 1: Comprendiendo y Utilizando Bucles (Loops)                        #
#-----------------------------------------------------------------------------#
# Los bucles son estructuras de control que permiten repetir un bloque de código múltiples veces.
# Aunque R es muy eficiente con operaciones vectorizadas, entender los bucles es fundamental.

#--------------------------#
# 1.1 Bucle 'for'          #
#--------------------------#
cat("\n--- 1.1 Bucle 'for' ---\n")
cat("--- Ejemplo 1.1.1: Bucle 'for' para imprimir nombres de columnas (iris) ---\n")
# Este bucle 'for' itera sobre los nombres de las columnas del data frame 'iris'.
# 'colnames(iris)' devuelve un vector de cadenas de caracteres, donde cada elemento
# es el nombre de una columna.  El bucle asigna cada uno de estos nombres
# a la variable 'nombre_columna' en cada iteración.

for (pos in seq_along(colnames(iris))) {
  # 'seq_along(colnames(iris))' genera una secuencia de enteros desde 1 hasta el número
  # total de columnas en el data frame 'iris'.  En cada iteración, 'pos' toma el
  # siguiente valor de esta secuencia, representando la posición de la columna.
  
  nombre_columna <- colnames(iris)[pos]
  # 'colnames(iris)[pos]' accede al vector de nombres de columna y obtiene el
  # nombre de la columna en la posición 'pos'. Este nombre se asigna a
  # la variable 'nombre_columna'.
  
  cat("Nombre de la columna (iris):", nombre_columna, ", Posición:", pos, "\n")
  # 'cat' se utiliza para imprimir en la consola.  Imprime el nombre de la columna
  # y su posición (índice) dentro del data frame.  '\n' inserta una nueva línea
  # después de cada impresión, para que cada nombre y posición aparezcan en líneas separadas.
}

cat("\n--- Ejemplo 1.1.2: Bucle 'for' para calcular la media de las columnas numéricas (iris) ---\n")
columnas_numericas_iris <- names(iris)[sapply(iris, is.numeric)]
medias_calculadas_for_iris <- numeric(length(columnas_numericas_iris))
names(medias_calculadas_for_iris) <- columnas_numericas_iris

for (i in 1:length(columnas_numericas_iris)) {
  col_actual <- columnas_numericas_iris[i]
  media_col <- mean(iris[[col_actual]], na.rm = TRUE)
  medias_calculadas_for_iris[col_actual] <- media_col
  cat("La media de la columna (iris) '", 
      col_actual, "' es: ", round(media_col, 2), "\n", sep="")
}
cat("\nMedias (iris) calculadas con bucle 'for':\n")
print(medias_calculadas_for_iris)

#--------------------------#
# 1.2 Bucle 'while'        #
#--------------------------#
cat("\n\n--- 1.2 Bucle 'while' ---\n")
cat("--- Ejemplo 1.2.1: Bucle 'while' para simular crecimiento poblacional simple ---\n")
poblacion_inicial <- 1000
tasa_crecimiento <- 0.05 # 5% anual
poblacion_objetivo <- 1500
anos <- 0
poblacion_actual_while <- poblacion_inicial

while (poblacion_actual_while < poblacion_objetivo) {
  poblacion_actual_while <- poblacion_actual_while * (1 + tasa_crecimiento)
  anos <- anos + 1
  cat("Año:", anos, "- Población actual:", round(poblacion_actual_while), "\n")
}
cat("Se necesitaron", anos, "años para alcanzar o superar la población objetivo de", poblacion_objetivo, ".\n")


#-----------------------------------------------------------------------------#
# Sección 2: Funciones de la Familia 'apply' - Alternativas Eficientes a Bucles #
#-----------------------------------------------------------------------------#
cat("\n\n#-----------------------------------------------------------------------------#")
cat("\n# Sección 2: Funciones de la Familia 'apply'                                #")
cat("\n#-----------------------------------------------------------------------------#\n")
# La familia 'apply' permite aplicar una función a elementos de un objeto
# de forma más concisa y, a menudo, más eficiente que los bucles explícitos.

#--------------------------#
# 2.1 'lapply' y 'sapply'  #
#--------------------------#
cat("\n--- 2.1 'lapply' y 'sapply' ---\n")
# 'lapply': Aplica una función a cada elemento de una lista o vector. Siempre devuelve una lista.
# 'sapply': Similar a 'lapply', pero intenta simplificar el resultado.

cat("--- Ejemplo 2.1.1: Básico con lista de vectores (lapply y sapply) ---\n")
lista_numeros <- list(a = 1:5, b = rnorm(5), c = c(10, NA, 20))
cat("Calculando la media de cada elemento de la lista:\n")
medias_lista_lapply <- lapply(lista_numeros, mean, na.rm = TRUE)
cat("Resultado con lapply (es una lista):\n")
print(medias_lista_lapply)

medias_lista_sapply <- sapply(lista_numeros, mean, na.rm = TRUE)
cat("\nResultado con sapply (simplificado a vector numérico):\n")
print(medias_lista_sapply)

cat("\n--- Ejemplo 2.1.2: Aplicado a 'gapminder' (columnas numéricas) ---\n")
# Seleccionar solo columnas numéricas de gapminder (excluyendo 'year' si se desea un tratamiento diferente)
gapminder_numeric_cols <- gapminder[sapply(gapminder, is.numeric)]

cat("Calculando la media de columnas numéricas de gapminder (lifeExp, pop, gdpPercap) usando sapply:\n")
medias_gapminder_sapply <- sapply(gapminder_numeric_cols[, c("lifeExp", "pop", "gdpPercap")], mean, na.rm = TRUE)
print(medias_gapminder_sapply)

cat("\nObteniendo la clase de cada columna en gapminder usando sapply:\n")
clases_gapminder <- sapply(gapminder, class)
print(clases_gapminder)

#--------------------------#
# 2.2 'apply'              #
#--------------------------#
cat("\n\n--- 2.2 'apply' ---\n")
# 'apply': Aplica una función a las filas (MARGIN=1) o columnas (MARGIN=2) de una matriz o data frame numérico.

cat("--- Ejemplo 2.2.1: Básico con matriz ---\n")
matriz_ejemplo <- matrix(1:12, nrow = 3, ncol = 4)
cat("Matriz de ejemplo:\n")
print(matriz_ejemplo)
sumas_filas_apply <- apply(matriz_ejemplo, 1, sum) # Suma por filas
cat("Suma de filas con apply:\n")
print(sumas_filas_apply)
medias_columnas_apply <- apply(matriz_ejemplo, 2, mean) # Media por columnas
cat("Media de columnas con apply:\n")
print(medias_columnas_apply)

cat("\n--- Ejemplo 2.2.2: Aplicado a 'iris' (columnas numéricas) ---\n")
medias_cols_iris_apply <- apply(iris[, 1:4], 2, mean)
cat("Medias de columnas numéricas de iris usando 'apply':\n")
print(medias_cols_iris_apply)

#--------------------------#
# 2.3 'tapply'             #
#--------------------------#
cat("\n\n--- 2.3 'tapply' ---\n")
# 'tapply': Aplica una función a subconjuntos de un vector, definidos por un factor (o lista de factores).

cat("--- Ejemplo 2.3.1: Básico con vector y factor ---\n")
valores_t <- c(10, 12, 15, 8, 9, 11)
grupos_t <- factor(c("A", "B", "A", "B", "A", "B"))
cat("Valores:", valores_t, "\n")
cat("Grupos:", as.character(grupos_t), "\n") # as.character para mejor visualización
medias_por_grupo_tapply <- tapply(valores_t, grupos_t, mean)
cat("Media de valores por grupo usando 'tapply':\n")
print(medias_por_grupo_tapply)

cat("\n--- Ejemplo 2.3.2: Aplicado a 'gapminder' ---\n")
cat("Calculando la esperanza de vida media ('lifeExp') por continente en 'gapminder':\n")
lifeExp_media_por_continente <- tapply(gapminder$lifeExp, gapminder$continent, mean, na.rm = TRUE)
print(lifeExp_media_por_continente)

cat("\nCalculando la población total ('pop') por año en 'gapminder' para el continente 'Asia':\n")
gapminder_asia <- gapminder[gapminder$continent == "Asia", ]
pop_total_asia_por_ano <- tapply(gapminder_asia$pop, gapminder_asia$year, sum, na.rm = TRUE)
cat("Población total en Asia por año (primeros 5 resultados):\n")
print(head(pop_total_asia_por_ano))

#--------------------------#
# 2.4 'mapply' / 'Map'     #
#--------------------------#
cat("\n\n--- 2.4 'mapply' / 'Map' ---\n")
# 'mapply': Aplica una función a los primeros elementos de varios argumentos de lista/vector, luego a los segundos, etc.

cat("--- Ejemplo 2.4.1: Básico con 'mapply' para crear secuencias ---\n")
# Crear secuencias: seq(1,3), seq(1,4), seq(1,5)
resultado_mapply_seq <- mapply(seq, from = 1, to = c(3, 4, 5)) # 'from' se recicla
cat("Resultado de mapply para crear secuencias (lista de secuencias):\n")
print(resultado_mapply_seq)

cat("\n--- Ejemplo 2.4.2: Aplicado a 'gapminder' (ejemplo construido) ---\n")
# Supongamos que queremos crear un identificador combinando las primeras 3 letras del país y el año.
# Usaremos una función anónima.
primeros_paises <- as.character(gapminder$country[1:5])
primeros_anos <- gapminder$year[1:5]

crear_id_pais_ano <- function(pais_nombre, anio_obs) {
  paste0(substr(pais_nombre, 1, 3), "_", anio_obs)
}
ids_generados_mapply <- mapply(crear_id_pais_ano, primeros_paises, primeros_anos)
cat("IDs generados (país_año) para los primeros 5 registros de gapminder:\n")
print(ids_generados_mapply)


#-----------------------------------------------------------------------------#
# Sección 3: Creación y Aplicación de Funciones Personalizadas                #
#-----------------------------------------------------------------------------#
cat("\n\n#-----------------------------------------------------------------------------#")
cat("\n# Sección 3: Creación y Aplicación de Funciones Personalizadas                #")
cat("\n#-----------------------------------------------------------------------------#\n")

cat("\n--- 3.1: Función para encontrar el máximo por grupo (ej. país con mayor población por continente/año) ---\n")
# Esta función muestra cómo se pueden combinar funciones de R base.

datos <- gapminder

encontrar_max_por_grupo <- function(datos, columna_valor, columna_grupo1, columna_grupo2 = NULL, columna_id_max) {
  # datos: data.frame
  # columna_valor: nombre de la columna numérica para encontrar el máximo
  # columna_grupo1: nombre de la primera columna de agrupación (factor)
  # columna_grupo2: (opcional) nombre de la segunda columna de agrupación (factor)
  # columna_id_max: nombre de la columna que identifica la fila con el máximo (ej. 'country')
  
  if (is.null(columna_grupo2)) {
    factores_agrupacion <- list(datos[[columna_grupo1]])
    nombres_factores <- columna_grupo1
  } else {
    factores_agrupacion <- list(datos[[columna_grupo1]], datos[[columna_grupo2]])
    nombres_factores <- c(columna_grupo1, columna_grupo2)
  }
  
  # Dividir el data frame en subconjuntos basados en los factores de agrupación
  datos_divididos <- split(datos, factores_agrupacion, drop = TRUE) # drop=TRUE para eliminar combinaciones vacías
  
  # Aplicar una función a cada subconjunto para encontrar la fila con el máximo valor
  resultado_lista <- lapply(datos_divididos, function(sub_df) {
    if (nrow(sub_df) == 0) return(NULL)
    fila_max <- sub_df[which.max(sub_df[[columna_valor]]), ]
    return(fila_max)
  })
  
  # Combinar los resultados en un único data frame
  resultado_df <- do.call(rbind, resultado_lista)
  rownames(resultado_df) <- NULL # Limpiar nombres de filas
  return(resultado_df)
}

cat("Encontrando el país con mayor población ('pop') por continente y año en 'gapminder' (mostrando algunos):\n")
# Para este ejemplo, tomaremos un subconjunto de años para que la salida no sea tan larga
gapminder_sub_anios <- gapminder[gapminder$year %in% c(1952, 2007), ]
max_pop_por_continente_anio <- encontrar_max_por_grupo(
  datos = gapminder_sub_anios,
  columna_valor = "pop",
  columna_grupo1 = "continent",
  columna_grupo2 = "year",
  columna_id_max = "country"
)
print(head(max_pop_por_continente_anio[, c("continent", "year", "country", "pop")], 10))

#-----------------------------------------------------------------------------#
# Sección 4: Consejos Adicionales para Funciones Eficientes y R base          #
#-----------------------------------------------------------------------------#

cat("--- 4.1 Evitar que los objetos crezcan dentro de los bucles (Pre-asignación) ---\n")
# MAL (Ineficiente):
# mi_vector_resultado_malo <- c()
# for (i in 1:10000) { mi_vector_resultado_malo <- c(mi_vector_resultado_malo, i*2) }
# BIEN (Pre-asignación):
cat("Ejemplo de pre-asignación (no se ejecuta la versión mala para ahorrar tiempo):\n")
n_elementos <- 10000
mi_vector_resultado_bueno <- numeric(n_elementos) # Pre-asigna un vector de ceros
for (i in 1:n_elementos) {
  mi_vector_resultado_bueno[i] <- i*2
}
cat("Primeros elementos del vector creado con pre-asignación:", head(mi_vector_resultado_bueno), "\n")


cat("\n--- 4.2 Usar la lógica booleana y la indexación (Subsetting) ---\n")
cat("Obtener datos de 'gapminder' para el continente 'Europe' con esperanza de vida > 75 años:\n")
# Ineficiente con bucle (no mostrado)
# Eficiente con indexación lógica:
gapminder_europa_longeva <- gapminder[gapminder$continent == "Europe" & gapminder$lifeExp > 75, ]
cat("Dimensiones del subconjunto 'gapminder_europa_longeva':", dim(gapminder_europa_longeva), "\n")
cat("Vista previa del subconjunto:\n")
print(head(gapminder_europa_longeva[, c("country", "year", "continent", "lifeExp")]))


cat("\n--- 4.3 Conocer y usar funciones de R base ---\n")
cat("R base ofrece muchas funciones optimizadas. Algunos ejemplos adicionales:\n")

# 'table()': para tablas de frecuencia
cat("Tabla de frecuencia de continentes en 'gapminder' (para el año 2007):\n")
print(table(gapminder[gapminder$year == 2007, "continent"]))

# 'unique()', 'length(unique())': para contar elementos únicos
cat("\nNúmero de países únicos en 'gapminder':", length(unique(gapminder$country)), "\n")

# 'sort()', 'order()': para ordenar
poblaciones_2007 <- gapminder[gapminder$year == 2007, c("country", "pop")]
poblaciones_2007_ordenadas <- poblaciones_2007[order(poblaciones_2007$pop, decreasing = TRUE), ]
cat("\nPaíses con mayor población en 2007 (Top 5):\n")
print(head(poblaciones_2007_ordenadas))

# 'rowSums()', 'colSums()', 'rowMeans()', 'colMeans()': para matrices y data frames numéricos
matriz_datos_iris <- as.matrix(iris[,1:4]) # Convertir a matriz para estas funciones
cat("\nSumas por fila de las medidas numéricas de iris (primeras 5):\n")
print(head(rowSums(matriz_datos_iris)))
cat("\nMedias por columna de las medidas numéricas de iris:\n")
print(colMeans(matriz_datos_iris))

# 'split()': divide un data frame o vector por grupos
lista_gapminder_por_continente <- split(gapminder, gapminder$continent)
cat("\n'gapminder' dividido por continente (se muestra la estructura del primer elemento - Africa):\n")
print(str(lista_gapminder_por_continente[[1]], max.level = 1)) # str del primer elemento
cat("Número de data frames en la lista (uno por continente):", length(lista_gapminder_por_continente), "\n")
# Luego se podría usar lapply para procesar cada data.frame en la lista.



=======
#-----------------------------------------------------------------------------#
# Script de R: Trabajo con Datos en R - Clase práctica 2                      #
# Foco: R base, Bucles (loops) y Creación/Aplicación de Funciones Eficientes #
# Trabajando con base Gapminder y Estructuras de Control                    #
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
# Sección 0: Introducción y Preparación del Entorno con R base                           #
#-----------------------------------------------------------------------------#

# R base se refiere a las funciones que vienen con la instalación estándar de R,
# sin necesidad de cargar paquetes adicionales para muchas tareas fundamentales.

cat("--- 0.1 Comandos básicos de salida: print() vs cat() ---\n")
# 'print()' es una función genérica que muestra objetos R.
# Es útil para inspeccionar el contenido de variables, vectores, data frames, etc.
# Generalmente añade metadatos como índices o niveles de factores.
un_vector <- c("a", "b", "c")
cat("Usando print() para un_vector:\n")
print(un_vector)

un_numero <- 10
cat("\nUsando print() para un_numero:\n")
print(un_numero)

# 'cat()' se usa para concatenar y mostrar salidas, ofreciendo más control sobre el formato.
# No añade metadatos por defecto y es bueno para crear mensajes o salidas formateadas.
# Necesita saltos de línea explícitos (\n).
cat("\nUsando cat() para un_vector y un_numero:\n")
cat("El vector es:", un_vector, "y el número es:", un_numero, "\n")
cat("Podemos concatenar múltiples elementos:", "Elemento1", 2, "Elemento3", "\n")
# A lo largo de este script, usaremos 'cat()' para mensajes explicativos
# y 'print()' para mostrar la estructura o contenido de objetos de datos.

cat("\n--- 0.2 Estructuras de Control Condicional ---\n")
# Las estructuras de control condicional permiten ejecutar diferentes bloques de código
# según se cumplan o no ciertas condiciones.

# if, else if, else
cat("\nEjemplo de if, else if, else:\n")
x <- 5  # Asigna el valor 5 a la variable 'x'.  Este es el valor que vamos a evaluar.

# Estructura de control 'if-else' anidada para evaluar el valor de 'x'.
# La estructura 'if-else' permite ejecutar diferentes bloques de código
# dependiendo de si una condición es verdadera o falsa.

if (x > 10) {
  # Si la condición 'x > 10' es VERDADERA, se ejecuta este bloque de código.
  cat("x es mayor que 10\n") # Imprime en la consola que 'x' es mayor que 10.
} else if (x > 0 && x <= 10) {
  # Si la condición anterior es FALSA, se evalúa esta condición.
  # La condición 'x > 0 && x <= 10' verifica si 'x' está entre 1 y 10 (inclusive).
  # '&&' es el operador lógico "y" (AND). Ambas subcondiciones deben ser verdaderas.
  cat("x es positivo y menor o igual a 10\n") # Imprime el mensaje correspondiente.
} else if (x == 0) {
  # Si las condiciones anteriores son FALSAS, se evalúa esta condición.
  # La condición 'x == 0' verifica si 'x' es igual a 0.
  # '==' es el operador de igualdad.
  cat("x es cero\n") # Imprime que 'x' es cero.
} else {
  # Si ninguna de las condiciones anteriores es VERDADERA, se ejecuta este bloque 'else'.
  # El bloque 'else' se ejecuta por defecto cuando ninguna de las condiciones 'if' o 'else if' se cumple.
  cat("x es negativo\n") # Imprime que 'x' es negativo.
}

y <- -3
if (y > 0) {
  cat("y (", y, ") es positivo.\n", sep="")
} else {
  cat("y (", y, ") no es positivo (es cero o negativo).\n", sep="")
}

# ifelse()
# Es una forma vectorizada de if-else.
# Sintaxis: ifelse(condicion, valor_si_verdadero, valor_si_falso)
cat("\nEjemplo de ifelse():\n")
numeros <- -3:3
resultado_ifelse <- ifelse(numeros > 0, "Positivo", "No Positivo")
print(data.frame(Numero = numeros, Clasificacion = resultado_ifelse))

# Ejemplo: Asignar 'grande' o 'pequeño' basado en un umbral
valores <- c(1, 5, 10, 15, 2, 8)
umbral <- 7
clasificacion_tamano <- ifelse(valores > umbral, "Grande", "Pequeño")
print(data.frame(Valor = valores, Tamano = clasificacion_tamano))


cat("\n--- 0.3 Preparando el Dataset de Ejemplo ---\n")
# Usaremos el dataset 'iris' para ejemplos básicos y el paquete 'gapminder' para ejemplos más aplicados.

# Dataset 'iris' (incorporado en R)
data(iris)
cat("--- Vista Previa del Dataset 'iris' ---\n")
print(head(iris))
cat("\n--- Estructura del Dataset 'iris' ---\n")
print(str(iris))

# Dataset 'gapminder'
# Primero, verificamos si el paquete está instalado. Si no, lo instalamos.
if (!requireNamespace("gapminder", quietly = TRUE)) {
  cat("Instalando el paquete 'gapminder'...\n")
  install.packages("gapminder")
}

library(gapminder) # Cargamos el paquete

cat("\n\n--- Vista Previa del Dataset 'gapminder' ---\n")
print(head(gapminder))
cat("\n--- Estructura del Dataset 'gapminder' ---\n")
print(str(gapminder))
cat("\n--- Resumen Estadístico del Dataset 'gapminder' ---\n")
# Mostraremos un resumen de las primeras columnas para brevedad
print(summary(gapminder[, c("country", "continent", "year", "lifeExp")]))


#-----------------------------------------------------------------------------#
# Sección 1: Comprendiendo y Utilizando Bucles (Loops)                        #
#-----------------------------------------------------------------------------#
# Los bucles son estructuras de control que permiten repetir un bloque de código múltiples veces.
# Aunque R es muy eficiente con operaciones vectorizadas, entender los bucles es fundamental.

#--------------------------#
# 1.1 Bucle 'for'          #
#--------------------------#
cat("\n--- 1.1 Bucle 'for' ---\n")
cat("--- Ejemplo 1.1.1: Bucle 'for' para imprimir nombres de columnas (iris) ---\n")
# Este bucle 'for' itera sobre los nombres de las columnas del data frame 'iris'.
# 'colnames(iris)' devuelve un vector de cadenas de caracteres, donde cada elemento
# es el nombre de una columna.  El bucle asigna cada uno de estos nombres
# a la variable 'nombre_columna' en cada iteración.

for (pos in seq_along(colnames(iris))) {
  # 'seq_along(colnames(iris))' genera una secuencia de enteros desde 1 hasta el número
  # total de columnas en el data frame 'iris'.  En cada iteración, 'pos' toma el
  # siguiente valor de esta secuencia, representando la posición de la columna.
  
  nombre_columna <- colnames(iris)[pos]
  # 'colnames(iris)[pos]' accede al vector de nombres de columna y obtiene el
  # nombre de la columna en la posición 'pos'. Este nombre se asigna a
  # la variable 'nombre_columna'.
  
  cat("Nombre de la columna (iris):", nombre_columna, ", Posición:", pos, "\n")
  # 'cat' se utiliza para imprimir en la consola.  Imprime el nombre de la columna
  # y su posición (índice) dentro del data frame.  '\n' inserta una nueva línea
  # después de cada impresión, para que cada nombre y posición aparezcan en líneas separadas.
}

cat("\n--- Ejemplo 1.1.2: Bucle 'for' para calcular la media de las columnas numéricas (iris) ---\n")
columnas_numericas_iris <- names(iris)[sapply(iris, is.numeric)]
medias_calculadas_for_iris <- numeric(length(columnas_numericas_iris))
names(medias_calculadas_for_iris) <- columnas_numericas_iris

for (i in 1:length(columnas_numericas_iris)) {
  col_actual <- columnas_numericas_iris[i]
  media_col <- mean(iris[[col_actual]], na.rm = TRUE)
  medias_calculadas_for_iris[col_actual] <- media_col
  cat("La media de la columna (iris) '", 
      col_actual, "' es: ", round(media_col, 2), "\n", sep="")
}
cat("\nMedias (iris) calculadas con bucle 'for':\n")
print(medias_calculadas_for_iris)

#--------------------------#
# 1.2 Bucle 'while'        #
#--------------------------#
cat("\n\n--- 1.2 Bucle 'while' ---\n")
cat("--- Ejemplo 1.2.1: Bucle 'while' para simular crecimiento poblacional simple ---\n")
poblacion_inicial <- 1000
tasa_crecimiento <- 0.05 # 5% anual
poblacion_objetivo <- 1500
anos <- 0
poblacion_actual_while <- poblacion_inicial

while (poblacion_actual_while < poblacion_objetivo) {
  poblacion_actual_while <- poblacion_actual_while * (1 + tasa_crecimiento)
  anos <- anos + 1
  cat("Año:", anos, "- Población actual:", round(poblacion_actual_while), "\n")
}
cat("Se necesitaron", anos, "años para alcanzar o superar la población objetivo de", poblacion_objetivo, ".\n")


#-----------------------------------------------------------------------------#
# Sección 2: Funciones de la Familia 'apply' - Alternativas Eficientes a Bucles #
#-----------------------------------------------------------------------------#
cat("\n\n#-----------------------------------------------------------------------------#")
cat("\n# Sección 2: Funciones de la Familia 'apply'                                #")
cat("\n#-----------------------------------------------------------------------------#\n")
# La familia 'apply' permite aplicar una función a elementos de un objeto
# de forma más concisa y, a menudo, más eficiente que los bucles explícitos.

#--------------------------#
# 2.1 'lapply' y 'sapply'  #
#--------------------------#
cat("\n--- 2.1 'lapply' y 'sapply' ---\n")
# 'lapply': Aplica una función a cada elemento de una lista o vector. Siempre devuelve una lista.
# 'sapply': Similar a 'lapply', pero intenta simplificar el resultado.

cat("--- Ejemplo 2.1.1: Básico con lista de vectores (lapply y sapply) ---\n")
lista_numeros <- list(a = 1:5, b = rnorm(5), c = c(10, NA, 20))
cat("Calculando la media de cada elemento de la lista:\n")
medias_lista_lapply <- lapply(lista_numeros, mean, na.rm = TRUE)
cat("Resultado con lapply (es una lista):\n")
print(medias_lista_lapply)

medias_lista_sapply <- sapply(lista_numeros, mean, na.rm = TRUE)
cat("\nResultado con sapply (simplificado a vector numérico):\n")
print(medias_lista_sapply)

cat("\n--- Ejemplo 2.1.2: Aplicado a 'gapminder' (columnas numéricas) ---\n")
# Seleccionar solo columnas numéricas de gapminder (excluyendo 'year' si se desea un tratamiento diferente)
gapminder_numeric_cols <- gapminder[sapply(gapminder, is.numeric)]

cat("Calculando la media de columnas numéricas de gapminder (lifeExp, pop, gdpPercap) usando sapply:\n")
medias_gapminder_sapply <- sapply(gapminder_numeric_cols[, c("lifeExp", "pop", "gdpPercap")], mean, na.rm = TRUE)
print(medias_gapminder_sapply)

cat("\nObteniendo la clase de cada columna en gapminder usando sapply:\n")
clases_gapminder <- sapply(gapminder, class)
print(clases_gapminder)

#--------------------------#
# 2.2 'apply'              #
#--------------------------#
cat("\n\n--- 2.2 'apply' ---\n")
# 'apply': Aplica una función a las filas (MARGIN=1) o columnas (MARGIN=2) de una matriz o data frame numérico.

cat("--- Ejemplo 2.2.1: Básico con matriz ---\n")
matriz_ejemplo <- matrix(1:12, nrow = 3, ncol = 4)
cat("Matriz de ejemplo:\n")
print(matriz_ejemplo)
sumas_filas_apply <- apply(matriz_ejemplo, 1, sum) # Suma por filas
cat("Suma de filas con apply:\n")
print(sumas_filas_apply)
medias_columnas_apply <- apply(matriz_ejemplo, 2, mean) # Media por columnas
cat("Media de columnas con apply:\n")
print(medias_columnas_apply)

cat("\n--- Ejemplo 2.2.2: Aplicado a 'iris' (columnas numéricas) ---\n")
medias_cols_iris_apply <- apply(iris[, 1:4], 2, mean)
cat("Medias de columnas numéricas de iris usando 'apply':\n")
print(medias_cols_iris_apply)

#--------------------------#
# 2.3 'tapply'             #
#--------------------------#
cat("\n\n--- 2.3 'tapply' ---\n")
# 'tapply': Aplica una función a subconjuntos de un vector, definidos por un factor (o lista de factores).

cat("--- Ejemplo 2.3.1: Básico con vector y factor ---\n")
valores_t <- c(10, 12, 15, 8, 9, 11)
grupos_t <- factor(c("A", "B", "A", "B", "A", "B"))
cat("Valores:", valores_t, "\n")
cat("Grupos:", as.character(grupos_t), "\n") # as.character para mejor visualización
medias_por_grupo_tapply <- tapply(valores_t, grupos_t, mean)
cat("Media de valores por grupo usando 'tapply':\n")
print(medias_por_grupo_tapply)

cat("\n--- Ejemplo 2.3.2: Aplicado a 'gapminder' ---\n")
cat("Calculando la esperanza de vida media ('lifeExp') por continente en 'gapminder':\n")
lifeExp_media_por_continente <- tapply(gapminder$lifeExp, gapminder$continent, mean, na.rm = TRUE)
print(lifeExp_media_por_continente)

cat("\nCalculando la población total ('pop') por año en 'gapminder' para el continente 'Asia':\n")
gapminder_asia <- gapminder[gapminder$continent == "Asia", ]
pop_total_asia_por_ano <- tapply(gapminder_asia$pop, gapminder_asia$year, sum, na.rm = TRUE)
cat("Población total en Asia por año (primeros 5 resultados):\n")
print(head(pop_total_asia_por_ano))

#--------------------------#
# 2.4 'mapply' / 'Map'     #
#--------------------------#
cat("\n\n--- 2.4 'mapply' / 'Map' ---\n")
# 'mapply': Aplica una función a los primeros elementos de varios argumentos de lista/vector, luego a los segundos, etc.

cat("--- Ejemplo 2.4.1: Básico con 'mapply' para crear secuencias ---\n")
# Crear secuencias: seq(1,3), seq(1,4), seq(1,5)
resultado_mapply_seq <- mapply(seq, from = 1, to = c(3, 4, 5)) # 'from' se recicla
cat("Resultado de mapply para crear secuencias (lista de secuencias):\n")
print(resultado_mapply_seq)

cat("\n--- Ejemplo 2.4.2: Aplicado a 'gapminder' (ejemplo construido) ---\n")
# Supongamos que queremos crear un identificador combinando las primeras 3 letras del país y el año.
# Usaremos una función anónima.
primeros_paises <- as.character(gapminder$country[1:5])
primeros_anos <- gapminder$year[1:5]

crear_id_pais_ano <- function(pais_nombre, anio_obs) {
  paste0(substr(pais_nombre, 1, 3), "_", anio_obs)
}
ids_generados_mapply <- mapply(crear_id_pais_ano, primeros_paises, primeros_anos)
cat("IDs generados (país_año) para los primeros 5 registros de gapminder:\n")
print(ids_generados_mapply)


#-----------------------------------------------------------------------------#
# Sección 3: Creación y Aplicación de Funciones Personalizadas                #
#-----------------------------------------------------------------------------#
cat("\n\n#-----------------------------------------------------------------------------#")
cat("\n# Sección 3: Creación y Aplicación de Funciones Personalizadas                #")
cat("\n#-----------------------------------------------------------------------------#\n")

cat("\n--- 3.1: Función para encontrar el máximo por grupo (ej. país con mayor población por continente/año) ---\n")
# Esta función muestra cómo se pueden combinar funciones de R base.

datos <- gapminder

encontrar_max_por_grupo <- function(datos, columna_valor, columna_grupo1, columna_grupo2 = NULL, columna_id_max) {
  # datos: data.frame
  # columna_valor: nombre de la columna numérica para encontrar el máximo
  # columna_grupo1: nombre de la primera columna de agrupación (factor)
  # columna_grupo2: (opcional) nombre de la segunda columna de agrupación (factor)
  # columna_id_max: nombre de la columna que identifica la fila con el máximo (ej. 'country')
  
  if (is.null(columna_grupo2)) {
    factores_agrupacion <- list(datos[[columna_grupo1]])
    nombres_factores <- columna_grupo1
  } else {
    factores_agrupacion <- list(datos[[columna_grupo1]], datos[[columna_grupo2]])
    nombres_factores <- c(columna_grupo1, columna_grupo2)
  }
  
  # Dividir el data frame en subconjuntos basados en los factores de agrupación
  datos_divididos <- split(datos, factores_agrupacion, drop = TRUE) # drop=TRUE para eliminar combinaciones vacías
  
  # Aplicar una función a cada subconjunto para encontrar la fila con el máximo valor
  resultado_lista <- lapply(datos_divididos, function(sub_df) {
    if (nrow(sub_df) == 0) return(NULL)
    fila_max <- sub_df[which.max(sub_df[[columna_valor]]), ]
    return(fila_max)
  })
  
  # Combinar los resultados en un único data frame
  resultado_df <- do.call(rbind, resultado_lista)
  rownames(resultado_df) <- NULL # Limpiar nombres de filas
  return(resultado_df)
}

cat("Encontrando el país con mayor población ('pop') por continente y año en 'gapminder' (mostrando algunos):\n")
# Para este ejemplo, tomaremos un subconjunto de años para que la salida no sea tan larga
gapminder_sub_anios <- gapminder[gapminder$year %in% c(1952, 2007), ]
max_pop_por_continente_anio <- encontrar_max_por_grupo(
  datos = gapminder_sub_anios,
  columna_valor = "pop",
  columna_grupo1 = "continent",
  columna_grupo2 = "year",
  columna_id_max = "country"
)
print(head(max_pop_por_continente_anio[, c("continent", "year", "country", "pop")], 10))

#-----------------------------------------------------------------------------#
# Sección 4: Consejos Adicionales para Funciones Eficientes y R base          #
#-----------------------------------------------------------------------------#

cat("--- 4.1 Evitar que los objetos crezcan dentro de los bucles (Pre-asignación) ---\n")
# MAL (Ineficiente):
# mi_vector_resultado_malo <- c()
# for (i in 1:10000) { mi_vector_resultado_malo <- c(mi_vector_resultado_malo, i*2) }
# BIEN (Pre-asignación):
cat("Ejemplo de pre-asignación (no se ejecuta la versión mala para ahorrar tiempo):\n")
n_elementos <- 10000
mi_vector_resultado_bueno <- numeric(n_elementos) # Pre-asigna un vector de ceros
for (i in 1:n_elementos) {
  mi_vector_resultado_bueno[i] <- i*2
}
cat("Primeros elementos del vector creado con pre-asignación:", head(mi_vector_resultado_bueno), "\n")


cat("\n--- 4.2 Usar la lógica booleana y la indexación (Subsetting) ---\n")
cat("Obtener datos de 'gapminder' para el continente 'Europe' con esperanza de vida > 75 años:\n")
# Ineficiente con bucle (no mostrado)
# Eficiente con indexación lógica:
gapminder_europa_longeva <- gapminder[gapminder$continent == "Europe" & gapminder$lifeExp > 75, ]
cat("Dimensiones del subconjunto 'gapminder_europa_longeva':", dim(gapminder_europa_longeva), "\n")
cat("Vista previa del subconjunto:\n")
print(head(gapminder_europa_longeva[, c("country", "year", "continent", "lifeExp")]))


cat("\n--- 4.3 Conocer y usar funciones de R base ---\n")
cat("R base ofrece muchas funciones optimizadas. Algunos ejemplos adicionales:\n")

# 'table()': para tablas de frecuencia
cat("Tabla de frecuencia de continentes en 'gapminder' (para el año 2007):\n")
print(table(gapminder[gapminder$year == 2007, "continent"]))

# 'unique()', 'length(unique())': para contar elementos únicos
cat("\nNúmero de países únicos en 'gapminder':", length(unique(gapminder$country)), "\n")

# 'sort()', 'order()': para ordenar
poblaciones_2007 <- gapminder[gapminder$year == 2007, c("country", "pop")]
poblaciones_2007_ordenadas <- poblaciones_2007[order(poblaciones_2007$pop, decreasing = TRUE), ]
cat("\nPaíses con mayor población en 2007 (Top 5):\n")
print(head(poblaciones_2007_ordenadas))

# 'rowSums()', 'colSums()', 'rowMeans()', 'colMeans()': para matrices y data frames numéricos
matriz_datos_iris <- as.matrix(iris[,1:4]) # Convertir a matriz para estas funciones
cat("\nSumas por fila de las medidas numéricas de iris (primeras 5):\n")
print(head(rowSums(matriz_datos_iris)))
cat("\nMedias por columna de las medidas numéricas de iris:\n")
print(colMeans(matriz_datos_iris))

# 'split()': divide un data frame o vector por grupos
lista_gapminder_por_continente <- split(gapminder, gapminder$continent)
cat("\n'gapminder' dividido por continente (se muestra la estructura del primer elemento - Africa):\n")
print(str(lista_gapminder_por_continente[[1]], max.level = 1)) # str del primer elemento
cat("Número de data frames en la lista (uno por continente):", length(lista_gapminder_por_continente), "\n")
# Luego se podría usar lapply para procesar cada data.frame en la lista.



>>>>>>> 8c32c39351ff53a885cec7dc623866b4ef73fc72
