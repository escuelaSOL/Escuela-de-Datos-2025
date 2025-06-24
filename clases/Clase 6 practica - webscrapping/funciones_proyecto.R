# Funcion instalar paquetes
instalar_paquetes <-  function(paquetes){
  paquetes_faltantes <- paquetes[!paquetes %in% installed.packages()[, "Package"]]
  if (length(paquetes_faltantes) > 0){
    install.packages(paquetes_faltantes, dependencies = TRUE)
  }
}

# Función para cargar librerias
cargar_librerias <- function(paquetes){
  invisible(lapply(paquetes, function(p){
    suppressPackageStartupMessages(library(p, character.only = TRUE))
  }))
}


