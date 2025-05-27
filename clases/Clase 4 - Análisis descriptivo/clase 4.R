# CLASE: Análisis descriptivo en R (usando dataset iris)

# OBJETIVO
# Aprender a aplicar análisis descriptivo en R para interpretar datos numéricos y categóricos usando funciones base.


# 1. INTRODUCCIÓN (5 min)
# ¿Qué es el análisis descriptivo?
# ¿Qué tipo de información nos da?
# ¿Por qué es útil antes de graficar o modelar?


# 2. DATASET DE TRABAJO: IRIS 
data(iris)
#Para ver los primeros registros o las primeras filas de la tabla:
head(iris)     

# Renombrar las variables a español
names(iris) <- c("largo_sepalo", "ancho_sepalo", "largo_petalo", "ancho_petalo", "especie")

# Explorar los datos

#¿Cuántas plantas midió Fisher? y ¿Cuántas variables observó?
dim(iris)        # Dimensiones del dataset

#¿Qué tipo de datos son estas variables?
str(iris)        # Estructura de variables

#¿Hay valores faltantes en alguna variable?
colSums(is.na(iris))

#Para un resumen general (medidas estadísticas básicas): 
summary(iris)    # Resumen general
#Mínimo
#Primer cuartil (25%)
#Mediana (50%)
#Promedio
#Tercer cuartil (75%)
#Máximo


# Funciones básicas para variables numéricas
mean(iris$largo_sepalo)
median(iris$largo_sepalo)
min(iris$ancho_petalo)
max(iris$ancho_petalo)
sd(iris$largo_petalo)
range(iris$ancho_sepalo)

# ¿Es 'especie' un factor?
is.factor(iris$especie)         
# Para definir 'especie' como un factor:
iris$especie<-as.factor(iris$especie)
# Confirmación de tipo
class(iris$especie) 
# ¿Cuántas especies contiene el factor?
unique(iris$especie)

# Frecuencia de cada categoría:
table(iris$especie)
# Frecuencia de cada categoría en porcentaje:
prop.table(table(iris$especie))
# Frecuencia de cada categoría en porcentaje redondeado:
round(prop.table(table(iris$especie)), 2)

# Conozcamos más de estas especies...

# Solo si no está instalado, cargar paquete dplyr para facilitar resumen por grupos
# install.packages("dplyr") 
library(dplyr)

# Ver tablas de resumen por variable

# Largo del sépalo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(largo_sepalo),
    sd = sd(largo_sepalo)
  )
# Las flores iris virginica tienen en promedio sus sépalos más largos
# Las flores iris setosa varían menos respecto al largo de sus sépalos

# Ancho del sépalo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(ancho_sepalo),
    sd = sd(ancho_sepalo)
  )
# Las flores iris setosa tienen en promedio sus sépalos más anchos
# Las flores iris versicolor varían menos respecto al ancho de sus sépalos

# Largo del pétalo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(largo_petalo),
    sd = sd(largo_petalo)
  )
# Las flores iris virginica tienen en promedio pétalos más largos
# Las flores iris setosa varían menos respecto al largo de sus pétalos

# Ancho del pétalo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(ancho_petalo),
    sd = sd(ancho_petalo)
  )
# Las flores iris virginica tienen en promedio pétalos más anchos
# Las flores iris setosa varían menos respecto al ancho de sus pétalos

# Crear tabla con medidas básicas por especie

tabla_resumen <- iris %>%
  group_by(especie) %>%
  summarise(
    Largo_Sepalo = paste0("Media: ", round(mean(largo_sepalo), 2), ", SD: ", round(sd(largo_sepalo), 2)),
    Ancho_Sepalo = paste0("Media: ", round(mean(ancho_sepalo), 2), ", SD: ", round(sd(ancho_sepalo), 2)),
    Largo_Petalo = paste0("Media: ", round(mean(largo_petalo), 2), ", SD: ", round(sd(largo_petalo), 2)),
    Ancho_Petalo = paste0("Media: ", round(mean(ancho_petalo), 2), ", SD: ", round(sd(ancho_petalo), 2))
  )

# Ver tabla resumen
tabla_resumen

# Correlaciones entre variables numéricas
# ¿Qué es la correlación?
# La correlación mide la fuerza y dirección de una relación lineal entre dos variables numéricas.
# Su valor va de -1 a 1:
# - Un valor cercano a 1 indica una relación positiva fuerte (cuando una sube, la otra también).
# - Un valor cercano a -1 indica una relación negativa fuerte (cuando una sube, la otra baja).
# - Un valor cercano a 0 indica que no hay relación lineal clara.
correlaciones <- cor(iris[, 1:4])
correlaciones   # Matriz de correlación
# Conclusiones:
# Fuerte correlación positiva entre: 
# 1.largo_petalo y ancho_petalo (0.96): a mayor largo del pétalo, mayor su ancho.
# 2.largo_sepalo y largo_petalo (0.87): flores con sépalos más largos tienden a tener pétalos más largos.
# Correlaciones negativas con ancho_sepalo: es débilmente inversa con otras variables, especialmente con largo_petalo (-0.43).

# VISUALIZACIONES SIMPLES
#Histograma
hist(iris$largo_sepalo, main = "Histograma del largo del sépalo", xlab = "Largo del sépalo", col = "lightblue")
# Histograma del largo del sépalo con líneas de cuartiles
abline(v = quantile(iris$largo_sepalo, probs = c(0.25, 0.5, 0.75)), col = "red", lty = 2)
# La mayoría de los valores del largo del sépalo se concentran alrededor de los 5.0 y 6.0 cm.
# La distribución es relativamente simétrica, con una leve inclinación hacia la izquierda.
# Los cuartiles ayudan a ver que el 50% central de los datos está bastante agrupado, lo que indica baja dispersión comparada con otras variables.

# Boxplot del largo del pétalo por especie
boxplot(largo_petalo ~ especie, data = iris, main = "Largo del pétalo por especie", xlab = "Especie", ylab = "Largo del pétalo", col = "lightgreen")
# La Iris virginica muestra los pétalos más largos en promedio.Esto se observa porque su mediana (línea dentro de la caja) está más alta que la de las otras especies.
# Iris virginica presenta la mayor dispersión: Su caja (rango intercuartílico) es más grande y también sus bigotes son más largos.
# Ees posible observar puntos aislados en una o más especies, fuera de los bigotes del boxplot. Estos representan valores atípicos en la longitud del pétalo.


# Gráfico de dispersión entre largo y ancho del pétalo
plot(iris$largo_petalo, iris$ancho_petalo, main = "Dispersión: largo vs ancho del pétalo",
     xlab = "Largo del pétalo", ylab = "Ancho del pétalo", col = iris$especie, pch = 19)
legend("topleft", legend = levels(iris$especie), col = 1:3, pch = 19)
# Se observa una fuerte relación positiva: a mayor largo del pétalo, mayor es su ancho.
# Las especies forman grupos visualmente diferenciables, especialmente Iris setosa, que tiene pétalos significativamente más cortos y estrechos.
# Esto refuerza lo que se observó en la matriz de correlación.

# Visualización largo del pétalo según especie
# install.packages("ggplot2") Solo si no lo tienes instalado
library(ggplot2)
tplot <- ggplot(iris, aes(x = largo_petalo, fill = especie)) +
  geom_histogram(position = "identity", alpha = 0.5, bins = 20) +
  labs(title = "Distribución del largo del pétalo por especie", x = "Largo del pétalo", y = "Frecuencia") +
  theme_minimal()
print(tplot)
# La especie Iris setosa es la especie que presenta menos dispersión respecto al largo de sus pétalos

