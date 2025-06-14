# Noticias economicas La tercera
# fecha: 14 de junio 2025
# autor: Escuela de datos

# Cargar funciones
# RECUERDA: Dentro de la funcion "source" debes indicar la ruta y el nombre del script que
# quieres ejecutar, en este caso el script donde tenemos las funciones: "instalar_paquetes" y
# "cargar_librerias". En este caso yo tenía el script en mi disco "D". Si creas un proyecto
# Será más facil vincular el script si están todos en la misma carpeta. 
source("D:/funciones_proyecto.R")

# Instalación de paquetes faltantes: creamos un vector con los paquetes que usaremos
paquetes <- c("rvest", 
              "RSelenium", 
              "httr", 
              "tidyverse")

# Funciones de instalacion y carga

# Revisa si los paquetes están instalados si no, los instala
instalar_paquetes(paquetes)

# Carga las librerias de los paquetes.
cargar_librerias(paquetes)


# Seleccionamos una web para scrapear
# Recuerda antes revisar los robots: www.paginaejemplo.cl/robots.txt


# URL a trabajar
url <- "https://www.latercera.com/canal/pulso"

# carga pagina
pagina_LTP <- read_html(url)

# Titulos
pagina_h2 <- pagina_LTP %>% html_elements("h2")

# tabla con la información
tabla_LTP <- tibble(
  Titular =  pagina_h2 %>%  
              html_elements("a") %>%  # Seleccionaremos los titulares de la web  en el elemento "a"
                html_text(),  # lo extraemos como texto
  Link = paste0("https://www.latercera.com",  # Ahora vamos con los links, pegamos esto que observamos no estaba en el elemento "a"
               str_squish(pagina_h2 %>%
                            html_elements("a") %>% 
                            html_attr("href") ) ) # Acá en href están el fragmento de los links
  
) %>% 
  filter(str_detect(Titular, "Iran")) # Podemos filtar por palabras para que aparezcan ciertos links

# Vemos la tabla
tabla_LTP %>% view() 




