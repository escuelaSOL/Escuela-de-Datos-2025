# CLASE: Visualizaci?n de datos en R (con dataset gapminder)

# OBJETIVO
# Aprender a crear visualizaciones con ggplot2 usando datos reales y globales.
# Se utilizar? el dataset 'gapminder' para explorar variables como esperanza de vida, poblaci?n y PIB per capita.


# INSTALACI?N Y CARGA DE PAQUETES NECESARIOS
# Solo si no est?n instalados:
##install.packages("gapminder") 
##install.packages("ggplot2")
##install.packages("ggthemes")
##install.packages("dplyr")
##install.packages("corrplot")


library(gapminder)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrplot)

# CARGA DEL DATASET
data(gapminder)
head(gapminder)

# RENOMBRAR VARIABLES AL ESPAñoL 
gapminder <- gapminder %>%
  rename(
    pais = country,
    continente = continent,
    anio = year,
    esperanza_vida = lifeExp,
    poblacion = pop,
    pib_per_capita = gdpPercap
  )

# EXPLORACI?N INICIAL DEL DATASET
dim(gapminder)  # dimensiones del dataset
str(gapminder)
summary(gapminder[,2:6])

## ?N.A?
# N?mero total de Años en el dataset
total_anios <- gapminder %>% 
  distinct(anio) %>% 
  nrow()
# Contar cu?ntos Años tiene cada País
gapminder %>%
  group_by(pais) %>%
  summarise(n_anios = n_distinct(anio)) %>%
  filter(n_anios < total_anios)
# Consultar si los registros est?n completos
gapminder %>%
  group_by(pais) %>%
  summarise(n_anios = n_distinct(anio)) %>%
  summarise(todos_completos = all(n_anios == total_anios))

# N? de paises registrados de cada continente
gapminder %>%
  filter(anio == 2007) %>%
  group_by(continente) %>%
  summarise(numero_paises = n_distinct(pais)) %>%
  arrange(desc(numero_paises))

# VISUALIZACIONES B?SICAS

# Diagrama de barras: n?mero de paises por continente (2007)
gapminder %>% 
  filter(anio == max(anio)) %>% 
  ggplot(aes(x = continente)) +
  geom_bar(fill = "orange") +
  labs(title = "Cantidad de paises por continente en 2007")
# Conclusi?n: ?frica es el continente con mas paises registrados en el dataset, seguido por Europa y Asia.

# Histograma de esperanza de vida
gapminder %>%
  filter(anio == 1952) %>%
  ggplot(aes(x = esperanza_vida)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  geom_vline(xintercept = c(41, 43), linetype = "dashed", color = "red", size = 0.7) +
  labs(
    title = "Distribucion de la esperanza de vida", 
    x = "Esperanza de vida", 
    y = "Frecuencia"
  )

gapminder %>%
  filter(anio == 2007) %>%
  ggplot(aes(x = esperanza_vida)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  geom_vline(xintercept = c(72, 74), linetype = "dashed", color = "red", size = 0.7) +
  labs(
    title = "Distribucion de la esperanza de vida", 
    x = "Esperanza de vida", 
    y = "Frecuencia"
  )

# Conclusi?n: Entra 1952 a 2007, la esperanza de vida pas? de 42 a 73 Años aproximadamente  

# paises con mayor y menor esperanza de vida en 2007
gapminder %>%
  filter(anio == 2007) %>%
  arrange(desc(esperanza_vida)) %>%
  select(pais, esperanza_vida) %>%
  slice(c(1, n()))

# Histograma de PIB
gapminder %>%
  filter(anio == 2007) %>%
  ggplot(aes(x = pib_per_capita)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  geom_vline(xintercept = 2000, linetype = "dashed", color = "red", size = 0.7) +
  labs(
    title = "Distribucion del PIB per capita en 2007", 
    x = "PIB per capita", 
    y = "Frecuencia"
  )
# Conclusi?n: la mayor?a de los paises tienen una esperanza de vida entre 60 y 75 Años, con pocos valores extremos.

# paises con mayor y menor PIB per capita
gapminder %>%
  filter(anio == 2007) %>%
  arrange(desc(pib_per_capita)) %>%
  select(pais, pib_per_capita) %>%
  slice(c(1,2,3, n()))

# Boxplot por continente
gapminder %>%
  filter(anio == 2007) %>%
  ggplot(aes(x = continente, y = esperanza_vida)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Esperanza de vida por continente (2007)", 
       x = "Continente", 
       y = "Esperanza de vida")
# Conclusi?n: ?frica tiene la esperanza de vida mas baja, mientras que Europa y Ocean?a presentan valores mas altos y homog?neos.

# paises con mayor y menor esperanza de vida
max_vida <- gapminder %>%
  filter(anio == 2007) %>%
  group_by(continente) %>%
  slice_max(order_by = esperanza_vida, n = 1, with_ties = FALSE) %>%
  select(continente, pais_max = pais, mayor_esperanza = esperanza_vida)

# M?nimo
min_vida <- gapminder %>%
  filter(anio == 2007) %>%
  group_by(continente) %>%
  slice_min(order_by = esperanza_vida, n = 1, with_ties = FALSE) %>%
  select(continente, pais_min = pais, menor_esperanza = esperanza_vida)

# Unir ambas
full_join(max_vida, min_vida, by = "continente")

# PIB per capita por continente
gapminder %>%
  filter(anio == 2007) %>%
  ggplot(aes(x = continente, y = pib_per_capita)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "PIB per capita por continente (2007)", 
       x = "Continente", 
       y = "PIB per capita")

# País con mayor PIB per capita por continente
max_pib <- gapminder %>%
  filter(anio == 2007) %>%
  group_by(continente) %>%
  slice_max(order_by = pib_per_capita, n = 1, with_ties = FALSE) %>%
  select(continente, pais_max_pib = pais, mayor_pib = pib_per_capita)

# País con menor PIB per capita por continente
min_pib <- gapminder %>%
  filter(anio == 2007) %>%
  group_by(continente) %>%
  slice_min(order_by = pib_per_capita, n = 1, with_ties = FALSE) %>%
  select(continente, pais_min_pib = pais, menor_pib = pib_per_capita)

# Unir ambas tablas
full_join(max_pib, min_pib, by = "continente")


# RELACIONES ENTRE VARIABLES

# Evolucion de la esperanza de vida promedio por continente
gapminder %>%
  group_by(anio, continente) %>%
  summarise(esperanza_promedio = mean(esperanza_vida), .groups = "drop") %>%
  ggplot(aes(x = anio, y = esperanza_promedio, color = continente)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Evolucion de la esperanza de vida por continente (1952?2007)",
    x = "Año",
    y = "Esperanza de vida promedio",
    color = "Continente"
  ) +
  theme_minimal()
# Conclusi?n: Este Grafico nos permite observar c?mo ha cambiado la esperanza de vida promedio en cada continente durante mas de 50 Años. Todos los continentes han experimentado mejoras, pero en diferentes magnitudes. ?frica, aunque ha avanzado, sigue rezagada respecto a Europa y Ocean?a, que muestran valores altos y sostenidos. Esta visualizaci?n es poderosa porque muestra tanto el presente como la trayectoria hist?rica del bienestar, y ayuda a reflexionar sobre desigualdades y progresos globales.


# L?nea de tendencia por País
# Japon:
gapminder %>% 
  filter(pais == "Japan") %>% 
  ggplot(aes(x = anio, y = esperanza_vida)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Evolucion de la esperanza de vida en Japan", y = "Esperanza de vida")
# Swaziland:
gapminder %>% 
  filter(pais == "Swaziland") %>% 
  ggplot(aes(x = anio, y = esperanza_vida)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Evolucion de la esperanza de vida en Swaziland", y = "Esperanza de vida")
# Chile:
gapminder %>% 
  filter(pais == "Chile") %>% 
  ggplot(aes(x = anio, y = esperanza_vida)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Evolucion de la esperanza de vida en Chile", y = "Esperanza de vida")
# Conclusi?n: en Chile y Jap?n, la esperanza de vida ha aumentado de forma constante entre 1952 y 2007, en Swaziland sin embargo, esta tendencia se interrupe en los 90's periodo donde comienza un descenso en la esperanza de vida promedio de la poblaci?n.

# Los 5 paises mas poblados en 2007
top_paises <- gapminder %>%
  filter(anio == 2007) %>%
  top_n(5, poblacion) %>%
  pull(pais)

# Grafico de l?neas
gapminder %>%
  filter(pais %in% top_paises) %>%
  ggplot(aes(x = anio, y = esperanza_vida, color = pais)) +
  geom_line(size = 1) +
  labs(
    title = "Evolucion de la esperanza de vida en los paises mas poblados",
    x = "Año",
    y = "Esperanza de vida"
  ) + theme_minimal()

# PIB mundial en 2007
pib_mundial_2007 <- gapminder %>%
  filter(anio == 2007) %>%
  mutate(pib_total = pib_per_capita * poblacion) %>%
  summarise(pib_mundial = sum(pib_total)) %>%
  pull(pib_mundial)
format(pib_mundial_2007, big.mark = ",", scientific = FALSE)

# Calcular PIB total por continente
pib_continente <- gapminder %>%
  filter(anio == 2007) %>%
  mutate(pib_total = pib_per_capita * poblacion) %>%
  group_by(continente) %>%
  summarise(pib_acumulado = sum(pib_total)) %>%
  mutate(porcentaje = pib_acumulado / sum(pib_acumulado) * 100)

# Grafico de torta
pib_continente <- pib_continente %>%
  mutate(continente = paste0(
    continente, 
    " (", format(round(porcentaje, 1), decimal.mark = ","), "%)"
  ))

ggplot(pib_continente, aes(x = "", y = porcentaje, fill = continente)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  labs(title = "Distribución del PIB mundial por continente (2007)", y = "", x = "") +
  theme_void() +
  theme(legend.title = element_blank())

# Evolucion en paises con mayor PIB
# 5 paises con mayor PIB per capita en 2007
paises_ricos <- gapminder %>%
  filter(anio == 2007) %>%
  arrange(desc(pib_per_capita)) %>%
  slice_head(n = 5) %>%
  pull(pais)

gapminder %>%  filter(pais == "United States") %>% View()

# Grafico
library(scales)
gapminder %>%
  filter(pais %in% paises_ricos) %>%
  ggplot(aes(x = anio, y = pib_per_capita, color = pais)) +
  geom_line(size = 1) +
  scale_y_log10(labels = label_comma(big.mark = ".", decimal.mark = ",")) +
  labs(
    title = "Evolución del PIB per cápita (5 países más ricos en 2007)", 
    x = "Año", y = "PIB per cápita", color = "País"
  ) +
  theme_minimal()

# Evolucion en paises con menor PIB
# 5 paises con menor PIB per capita en 2007
paises_pobres <- gapminder %>%
  filter(anio == 2007) %>%
  arrange(pib_per_capita) %>%
  slice_head(n = 5) %>%
  pull(pais)

# Grafico
gapminder %>%
  filter(pais %in% paises_pobres) %>%
  ggplot(aes(x = anio, y = pib_per_capita, color = pais)) +
  geom_line(size = 1) +
  scale_y_log10(labels = label_comma(big.mark = ".", decimal.mark = ",")) +
  labs(
    title = "Evolución del PIB per cápita (5 países más pobres en 2007)", 
    x = "Año", y = "PIB per cápita", color = "País"
  ) +
  theme_minimal()

# Evolucion del PIB en paises de Sudamerica
paises_sudamericanos <- c("Chile", "Argentina", "Brasil", "Peru", "Uruguay", "Colombia")
gapminder %>%
  filter(pais %in% paises_sudamericanos) %>%
  ggplot(aes(x = anio, y = pib_per_capita, color = pais)) +
  geom_line(size = 1) +
  scale_y_log10(labels = label_comma(big.mark = ".", decimal.mark = ",")) +
  labs(
    title = "Evolución del PIB per cápita (países sudamericanos)", 
    x = "Año", y = "PIB per cápita", color = "País"
  ) +
  theme_minimal()
# Conclusi?n: Conclusi?n: Chile y Uruguay muestran incrementos mas sostenidos; algunos paises tienen trayectorias mas irregulares.

# Dispersi?n: PIB per capita vs esperanza de vida (2007)
gapminder %>% 
  filter(anio == 2007) %>% 
  ggplot(aes(x = pib_per_capita, y = esperanza_vida)) +
  geom_point(aes(size = poblacion, color = continente), alpha = 0.7) +
  scale_x_log10(labels = label_comma(big.mark = ".", decimal.mark = ",")) +
  scale_size_continuous(
    name = "Población",
    labels = label_comma(big.mark = ".", decimal.mark = ",") ) +
  labs(
    title = "PIB per cápita vs Esperanza de vida (2007)", 
    x = "PIB per cápita", 
    y = "Esperanza de vida") +
  theme(
    legend.text = element_text(size = 8),
    legend.title = element_text(size = 9, face = "bold"),
    legend.key.size = unit(0.3, "cm"))
# Conclusi?n: existe una fuerte Relacion positiva: paises con mayor PIB per capita tienden a tener mayor esperanza de vida.

# Facetas por continente
gapminder %>%
  filter(anio == 2007) %>%
  ggplot(aes(x = pib_per_capita, y = esperanza_vida, color = continente)) +
  geom_point(alpha = 0.7) +
  facet_wrap(~ continente, scales = "free_x") +
  scale_x_continuous(
    labels = label_comma(big.mark = ".", decimal.mark = ",")
  ) +
  labs(
    title = "Relación entre PIB y esperanza de vida por continente (2007)",
    x = "PIB per cápita",
    y = "Esperanza de vida"
  ) +
  theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1))
# Conclusi?n: la Relacion positiva entre PIB y esperanza de via se deja ver en todos los continentes, pero en Africa se observan comportamientos distintos

# Matriz de corRelacion para 2007
cor_data <- gapminder %>% 
  filter(anio == 2007) %>% 
  select(esperanza_vida, pib_per_capita, poblacion) %>% 
  cor()
par(pty = "s")  # hace el gráfico cuadrado, más compacto
par(mar = c(2, 2, 2, 2))  # ajusta márgenes: abajo, izq, arriba, der
corrplot(
  cor_data,
  method = "color",
  addCoef.col = "black",
  tl.cex = 0.7,
  cl.cex = 0.7,       
  number.cex = 0.8    )
# Conclusi?n: el PIB per capita y la esperanza de vida est?n fuertemente correlacionados. La poblaci?n muestra una Relacion mas d?bil con ambas.

# Filtrar los datos solo para Europa en 2007
cor_data_europa <- gapminder %>%
  filter(anio == 2007, continente == "Europe") %>%
  select(esperanza_vida, pib_per_capita, poblacion) %>%
  cor()

# Visualizar la matriz de corRelacion
par(pty = "s")  # hace el gráfico cuadrado, más compacto
par(mar = c(2, 2, 2, 2))  # ajusta márgenes: abajo, izq, arriba, der
corrplot(
  cor_data_europa,
  method = "color",
  addCoef.col = "black",
  tl.cex = 0.7,
  cl.cex = 0.7,       
  number.cex = 0.8    )
# Filtrar los datos solo para Africa en 2007
cor_data_africa <- gapminder %>%
  filter(anio == 2007, continente == "Africa") %>%
  select(esperanza_vida, pib_per_capita, poblacion) %>%
  cor()

# Visualizar la matriz de corRelacion
par(pty = "s")  # hace el gráfico cuadrado, más compacto
par(mar = c(2, 2, 2, 2))  # ajusta márgenes: abajo, izq, arriba, der
corrplot(
  cor_data_africa,
  method = "color",
  addCoef.col = "black",
  tl.cex = 0.7,
  cl.cex = 0.7,       
  number.cex = 0.8    )


