library('rvest') 
library('tidyverse')

## Ejemplo Escuela

escuela<-read_html("https://aulavirtual.escuelasol.cl/escuela-de-datos")

# o como generalmente se especifica: 

url = "https://aulavirtual.escuelasol.cl/escuela-de-datos"
escuela<-read_html(url)

# buscamos elementos del tipo tabla
escuela %>% html_element("table")

# extraemos el elemento tabla
escuela<-escuela %>% html_table(fill=TRUE, header=TRUE, na.strings="")

escuela<-as.data.frame(escuela)

# extraeremos los elementos de la tabla

contenidos<-as.vector(escuela$Contenidos)

lista_contenidos<-strsplit(contenidos, split = "\n")

clases<-sapply(lista_contenidos,"[[",1)
descripcion<-sapply(lista_contenidos,"[[",2)

descripcion<-str_squish(descripcion)
descripcion<-str_replace(descripcion, "\\s{2,}", "_")

fechas<-as.vector(escuela$Fechas.de.clase)

lista_fechas<-strsplit(fechas, split = "\n")

fechas_clases<-sapply(lista_fechas,"[[",1)
fechas_practica<-sapply(lista_fechas,"[[",2)

fechas_clases<-gsub(".*:","",fechas_clases)
fechas_clases<-str_squish(fechas_clases)

fechas_practica<-gsub(".*:","",fechas_practica)
fechas_practica<-str_squish(fechas_practica)

# luego reconstruimos la tabla y la exportamos a un archivo

escuela_datos<-as.data.frame(cbind(clases,fechas_clases,fechas_practica,descripcion))

write.table(escuela_datos,file="/home/ubuk/Escritorio/escueladatos.txt",sep=";", row.names=FALSE,quote=FALSE,col.names=TRUE)

## Ejemplo Peliculas

# requerimos el paquete xml2 

library('xml2')

peliculas<-read_html("https://www.imdb.com/chart/top/")

peliculas %>% html_elements("table")

# con inspector de elementos del navegador identificamos el elemento título

titulo<-html_nodes(peliculas,".ipc-title-link-wrapper") %>% html_text

# luego extraemos los metadatos

metadatos<-html_nodes(peliculas,".cli-title-metadata") %>% html_text

year<-as.numeric(substr(metadatos,1,4))
duracion<-substr(metadatos,5,9)
rating<-substr(metadatos,10,20)

top25<-as.data.frame(cbind(titulo,year,duracion,rating))

hist(year)

boxplot(year)

