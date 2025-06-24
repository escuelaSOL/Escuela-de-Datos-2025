<<<<<<< HEAD
#-----------------------------------------------------------------------------#
# Script de R:  clase práctica 25 05 17                                       #
# Foco:         practica código y preguntas sobre bucles y funciones          #
# Versión:    1                                                               #
# Autoria:          Escuela de Datos                                          #
#-----------------------------------------------------------------------------#


# introducción ------------------------------------------------------------

cat("Comandos básicos")
# print("Comandos básicos")

view("comandos") # paquete tidyverse, por eso da error
View("comandos") # r base

vector <- c("a","b","f")

# Prubea de funciones básicas
cat(vector)
print(vector)
View(vector)

# Estructura if

x <- 3

if (x > 10){
  cat("x es mayor que 10\n")
  
  suma <- x + 1
  
  cat("El valor de x + 1, es: ", suma)
}


# Estructura if else

variable <- 10

if (variable < 10){
  
  cat("Variable es menor que 10")

} else {
  
  cat("La variable es mayor o igual a 10")
  
} 

# Estructura else if

numero <- -1

if (numero > 10){
  
  cat("El numero es mayor que 10")
  
} else if (numero > 0 | numero <= 10) {
  
  cat("El numero es positivo y menor o igual a 10")
  
} else if (numero == 0){
  
  cat("El numero es igual a 0")
  
} else if (numero < 0) {
  
  cat("El numero menor es menor a 0")
  
} 

# Operadores de comparación

#  < menor que
#  > mayor que
#  == igualdad 
#  & and ("y")
#  && y estricto 
#  | or  ("o")

# TRUE o FALSE

# Función ifelse

numeros <- c(-1,-2, 1,-2,3,-4)

# ifelse(condición, se cumple, no se cumple)

ifelse(numeros > 0, 
       "El numero es positivo", 
       "El numero es negativo")


# codigo de prueba estudiante
numeros <- c(-1,-2,1,2,3,4)

# if else(condición, se cumple, no se cumple)
ifelse(numeros > 0, 
       "El numero es positivo",
       "El numero es negativo")

# Ejemplo con igual a 0 


numeros <- c(0, -1,-2, 1,-2,3,-4)

# ifelse(condición, se cumple, no se cumple)

ifelse(numeros > 0, 
       "El numero es positivo", 
       ifelse(numeros == 0, 
              "El numero es igual a 0",
              ifelse(numeros < 0, 
                     "El numero es negativo",
                     "El numero positivo o igual a cero")))


# Ejemplos de clase 

numeros <- c(0, -1, -2, 1, -2, 3, -4)

# ifelse(condición, se cumple, no se cumple)

ifelse(numeros > 0, 
       "El numero es positivo", 
       "El numero es negativo")

edad <- c(10,2,18,22,24,77)

ifelse(edad >= 18, 
       "Es mayor de edad",
       "Es menor de edad")

notas <- c(4.0, 3.2, 7.0, 6.8)
promedio <- mean(notas)
ifelse(promedio > 4.0, 
       'Aprobado',
       'Reprobado')

numeros <- c(-1, -1, 1, 2, 3, -4)
ifelse(length(numeros) > 5,
       "hay más de 5 numeros",
       "hay 5 o menos numeros")

prueba_matematicas <- c(6,3,2,5,7)
ifelse(prueba_matematicas >= 4, 
       "Aprueba", 
       "Reprueba")


renta <- c(500000, 300000,320000,600000)

renta_media <- mean(renta)

evaluacion_renta <- ifelse(renta < renta_media, 
       "renta bajo la media",
       "renta sobre la media")

print(evaluacion_renta)


alturas <- c(1.50, 1.68, 1.80, 1.45)
ifelse(alturas >= 1.60, "alto", "medio")

# Estructura for

for (variable in vector) {
  
}

# Ejemplo con iris

for (pos in seq_along(colnames(iris))) {

  nombre_columna <-  colnames(iris)[pos]
  
  cat("nombre de la columna (iris)", 
      nombre_columna, "Posición: ", 
      pos, "\n")
  
}

=======
#-----------------------------------------------------------------------------#
# Script de R:  clase práctica 25 05 17                                       #
# Foco:         practica código y preguntas sobre bucles y funciones          #
# Versión:    1                                                               #
# Autoria:          Escuela de Datos                                          #
#-----------------------------------------------------------------------------#


# introducción ------------------------------------------------------------

cat("Comandos básicos")
# print("Comandos básicos")

view("comandos") # paquete tidyverse, por eso da error
View("comandos") # r base

vector <- c("a","b","f")

# Prubea de funciones básicas
cat(vector)
print(vector)
View(vector)

# Estructura if

x <- 3

if (x > 10){
  cat("x es mayor que 10\n")
  
  suma <- x + 1
  
  cat("El valor de x + 1, es: ", suma)
}


# Estructura if else

variable <- 10

if (variable < 10){
  
  cat("Variable es menor que 10")

} else {
  
  cat("La variable es mayor o igual a 10")
  
} 

# Estructura else if

numero <- -1

if (numero > 10){
  
  cat("El numero es mayor que 10")
  
} else if (numero > 0 | numero <= 10) {
  
  cat("El numero es positivo y menor o igual a 10")
  
} else if (numero == 0){
  
  cat("El numero es igual a 0")
  
} else if (numero < 0) {
  
  cat("El numero menor es menor a 0")
  
} 

# Operadores de comparación

#  < menor que
#  > mayor que
#  == igualdad 
#  & and ("y")
#  && y estricto 
#  | or  ("o")

# TRUE o FALSE

# Función ifelse

numeros <- c(-1,-2, 1,-2,3,-4)

# ifelse(condición, se cumple, no se cumple)

ifelse(numeros > 0, 
       "El numero es positivo", 
       "El numero es negativo")


# codigo de prueba estudiante
numeros <- c(-1,-2,1,2,3,4)

# if else(condición, se cumple, no se cumple)
ifelse(numeros > 0, 
       "El numero es positivo",
       "El numero es negativo")

# Ejemplo con igual a 0 


numeros <- c(0, -1,-2, 1,-2,3,-4)

# ifelse(condición, se cumple, no se cumple)

ifelse(numeros > 0, 
       "El numero es positivo", 
       ifelse(numeros == 0, 
              "El numero es igual a 0",
              ifelse(numeros < 0, 
                     "El numero es negativo",
                     "El numero positivo o igual a cero")))


# Ejemplos de clase 

numeros <- c(0, -1, -2, 1, -2, 3, -4)

# ifelse(condición, se cumple, no se cumple)

ifelse(numeros > 0, 
       "El numero es positivo", 
       "El numero es negativo")

edad <- c(10,2,18,22,24,77)

ifelse(edad >= 18, 
       "Es mayor de edad",
       "Es menor de edad")

notas <- c(4.0, 3.2, 7.0, 6.8)
promedio <- mean(notas)
ifelse(promedio > 4.0, 
       'Aprobado',
       'Reprobado')

numeros <- c(-1, -1, 1, 2, 3, -4)
ifelse(length(numeros) > 5,
       "hay más de 5 numeros",
       "hay 5 o menos numeros")

prueba_matematicas <- c(6,3,2,5,7)
ifelse(prueba_matematicas >= 4, 
       "Aprueba", 
       "Reprueba")


renta <- c(500000, 300000,320000,600000)

renta_media <- mean(renta)

evaluacion_renta <- ifelse(renta < renta_media, 
       "renta bajo la media",
       "renta sobre la media")

print(evaluacion_renta)


alturas <- c(1.50, 1.68, 1.80, 1.45)
ifelse(alturas >= 1.60, "alto", "medio")

# Estructura for

for (variable in vector) {
  
}

# Ejemplo con iris

for (pos in seq_along(colnames(iris))) {

  nombre_columna <-  colnames(iris)[pos]
  
  cat("nombre de la columna (iris)", 
      nombre_columna, "Posición: ", 
      pos, "\n")
  
}

>>>>>>> 8c32c39351ff53a885cec7dc623866b4ef73fc72
