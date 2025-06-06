# CLASE: An�lisis descriptivo en R (usando dataset iris)

# OBJETIVO
# Aprender a aplicar an�lisis descriptivo en R para interpretar datos num�ricos y categ�ricos usando funciones base.


# 1. INTRODUCCI�N (5 min)
# �Qu� es el an�lisis descriptivo?
# �Qu� tipo de informaci�n nos da?
# �Por qu� es �til antes de graficar o modelar?


# 2. DATASET DE TRABAJO: IRIS 
data(iris)
#Para ver los primeros registros o las primeras filas de la tabla:
head(iris)     

# Renombrar las variables a espa�ol
names(iris) <- c("largo_sepalo", "ancho_sepalo", "largo_petalo", "ancho_petalo", "especie")

# Explorar los datos

#�Cu�ntas plantas midi� Fisher? y �Cu�ntas variables observ�?
dim(iris)        # Dimensiones del dataset

#�Qu� tipo de datos son estas variables?
str(iris)        # Estructura de variables

#�Hay valores faltantes en alguna variable?
colSums(is.na(iris))

#Para un resumen general (medidas estad�sticas b�sicas): 
summary(iris)    # Resumen general
#M�nimo
#Primer cuartil (25%)
#Mediana (50%)
#Promedio
#Tercer cuartil (75%)
#M�ximo


# Funciones b�sicas para variables num�ricas
mean(iris$largo_sepalo)
median(iris$largo_sepalo)
min(iris$ancho_petalo)
max(iris$ancho_petalo)
sd(iris$largo_petalo)
range(iris$ancho_sepalo)

# �Es 'especie' un factor?
is.factor(iris$especie)         
# Para definir 'especie' como un factor:
iris$especie<-as.factor(iris$especie)
# Confirmaci�n de tipo
class(iris$especie) 
# �Cu�ntas especies contiene el factor?
unique(iris$especie)

# Frecuencia de cada categor�a:
table(iris$especie)
# Frecuencia de cada categor�a en porcentaje:
prop.table(table(iris$especie))
# Frecuencia de cada categor�a en porcentaje redondeado:
round(prop.table(table(iris$especie)), 2)

# Conozcamos m�s de estas especies...

# Solo si no est� instalado, cargar paquete dplyr para facilitar resumen por grupos
# install.packages("dplyr") 
library(dplyr)

# Ver tablas de resumen por variable

# Largo del s�palo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(largo_sepalo),
    sd = sd(largo_sepalo)
  )
# Las flores iris virginica tienen en promedio sus s�palos m�s largos
# Las flores iris setosa var�an menos respecto al largo de sus s�palos

# Ancho del s�palo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(ancho_sepalo),
    sd = sd(ancho_sepalo)
  )
# Las flores iris setosa tienen en promedio sus s�palos m�s anchos
# Las flores iris versicolor var�an menos respecto al ancho de sus s�palos

# Largo del p�talo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(largo_petalo),
    sd = sd(largo_petalo)
  )
# Las flores iris virginica tienen en promedio p�talos m�s largos
# Las flores iris setosa var�an menos respecto al largo de sus p�talos

# Ancho del p�talo
iris %>% 
  group_by(especie) %>% 
  summarise(
    media = mean(ancho_petalo),
    sd = sd(ancho_petalo)
  )
# Las flores iris virginica tienen en promedio p�talos m�s anchos
# Las flores iris setosa var�an menos respecto al ancho de sus p�talos

# Crear tabla con medidas b�sicas por especie

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

# Correlaciones entre variables num�ricas
# �Qu� es la correlaci�n?
# La correlaci�n mide la fuerza y direcci�n de una relaci�n lineal entre dos variables num�ricas.
# Su valor va de -1 a 1:
# - Un valor cercano a 1 indica una relaci�n positiva fuerte (cuando una sube, la otra tambi�n).
# - Un valor cercano a -1 indica una relaci�n negativa fuerte (cuando una sube, la otra baja).
# - Un valor cercano a 0 indica que no hay relaci�n lineal clara.
correlaciones <- cor(iris[, 1:4])
correlaciones   # Matriz de correlaci�n
# Conclusiones:
# Fuerte correlaci�n positiva entre: 
# 1.largo_petalo y ancho_petalo (0.96): a mayor largo del p�talo, mayor su ancho.
# 2.largo_sepalo y largo_petalo (0.87): flores con s�palos m�s largos tienden a tener p�talos m�s largos.
# Correlaciones negativas con ancho_sepalo: es d�bilmente inversa con otras variables, especialmente con largo_petalo (-0.43).

# VISUALIZACIONES SIMPLES
#Histograma
hist(iris$largo_sepalo, main = "Histograma del largo del s�palo", xlab = "Largo del s�palo", col = "lightblue")
# Histograma del largo del s�palo con l�neas de cuartiles
abline(v = quantile(iris$largo_sepalo, probs = c(0.25, 0.5, 0.75)), col = "red", lty = 2)
# La mayor�a de los valores del largo del s�palo se concentran alrededor de los 5.0 y 6.0 cm.
# La distribuci�n es relativamente sim�trica, con una leve inclinaci�n hacia la izquierda.
# Los cuartiles ayudan a ver que el 50% central de los datos est� bastante agrupado, lo que indica baja dispersi�n comparada con otras variables.

# Boxplot del largo del p�talo por especie
boxplot(largo_petalo ~ especie, data = iris, main = "Largo del p�talo por especie", xlab = "Especie", ylab = "Largo del p�talo", col = "lightgreen")
# La Iris virginica muestra los p�talos m�s largos en promedio.Esto se observa porque su mediana (l�nea dentro de la caja) est� m�s alta que la de las otras especies.
# Iris virginica presenta la mayor dispersi�n: Su caja (rango intercuart�lico) es m�s grande y tambi�n sus bigotes son m�s largos.
# Ees posible observar puntos aislados en una o m�s especies, fuera de los bigotes del boxplot. Estos representan valores at�picos en la longitud del p�talo.


# Gr�fico de dispersi�n entre largo y ancho del p�talo
plot(iris$largo_petalo, iris$ancho_petalo, main = "Dispersi�n: largo vs ancho del p�talo",
     xlab = "Largo del p�talo", ylab = "Ancho del p�talo", col = iris$especie, pch = 19)
legend("topleft", legend = levels(iris$especie), col = 1:3, pch = 19)
# Se observa una fuerte relaci�n positiva: a mayor largo del p�talo, mayor es su ancho.
# Las especies forman grupos visualmente diferenciables, especialmente Iris setosa, que tiene p�talos significativamente m�s cortos y estrechos.
# Esto refuerza lo que se observ� en la matriz de correlaci�n.

# Visualizaci�n largo del p�talo seg�n especie
# install.packages("ggplot2") Solo si no lo tienes instalado
library(ggplot2)
tplot <- ggplot(iris, aes(x = largo_petalo, fill = especie)) +
  geom_histogram(position = "identity", alpha = 0.5, bins = 20) +
  labs(title = "Distribuci�n del largo del p�talo por especie", x = "Largo del p�talo", y = "Frecuencia") +
  theme_minimal()
print(tplot)
# La especie Iris setosa es la especie que presenta menos dispersi�n respecto al largo de sus p�talos

