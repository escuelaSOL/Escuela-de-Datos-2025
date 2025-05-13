# Estructura básica de una función
nombre<-function(variables){
cuerpo
}

# Si recurrimos al data frame utilizado en la clase anterior
df_personas <- data.frame(
  ID = 1:10,
  Nombre = c("Ana","Luis","Eva","Diego","Juan","Marcela","Diego","Jocelyn","Raquel","Alejandra"),
  Edad = c(28,34,39,45,14,65,52,27,62,28),
  Ocupación = c(TRUE,TRUE,FALSE,TRUE,FALSE,FALSE,TRUE,FALSE,FALSE,TRUE),
  Ingreso = c(510636,600000,80000,420000,224004,70000,530000,50000,224004,380000),
  Gasto = c(700000,900000,120000,920000,200000,300000,1130000,600000,700000,880000)
)

resumen <- function(vector){
    maximo <-max(vector)
    media <-mean(vector)
    mediana <- median(vector)
    minimo <- min(vector)
    return(c(maximo,media,mediana,minimo))
}

#Aplicamos sobre el vector 
edad<-as.vector(df_personas$Edad)
print(resumen(edad))

ingreso<-as.vector(df_personas$Ingreso)
print(resumen(ingreso))

gasto<-as.vector(df_personas$Gasto)
print(resumen(gasto))

##Ejemplo de función intervalo de confianza

mean_ci <- function(x, conf = 0.98) {
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - conf
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
}

## Dos funciones anidadas

resumen <- function(vector){
  mean_ci <- function(x, conf = 0.95) {
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - conf
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
  }
    interval <-mean_ci(vector)
    maximo <-max(vector)
    media <-mean(vector)
    mediana <- median(vector)
    minimo <- min(vector)
    return(c(maximo,media,mediana,minimo,interval))
}

print(resumen(edad))
print(resumen(ingreso))
print(resumen(gasto))

#Aplicar función a una lista de vectores

lista<-list(a=edad,b=ingreso,c=gasto)
lapply(lista,resumen)

#¿Qué es un Loop?

for (i in 1:5) {
  print(i)
}

# En relación al ejemplo anterior

for (element in lista) {
  print(resumen(element))
}

# Ejemplo de función condicional

ocupa <- ifelse(df_personas$Ocupación == TRUE, "Ocupado/a", "No ocupado/a")
ocupa2 <-as.vector(df_personas$Ocupación)
ocupa2


for (i in 1:16){
  print(resumen(edad))
}

