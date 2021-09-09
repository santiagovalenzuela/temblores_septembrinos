rm(list = ls(all=T))

library(lubridate)
library(tidyverse)

sismos <- read.csv("SSNMX_catalogo_19000101_20210909_utc.csv", skip = 4)

# Limpiamos el dataset

sismos <- sismos %>%
  mutate(fecha = as_date(Fecha.local),
         mes = as.factor(month(floor_date(fecha, unit = "month")))
  )

sismos$Magnitud[sismos$Magnitud == "no calculable"] <- NA
sismos$Magnitud <- as.numeric(sismos$Magnitud)

options(expressions=10000)

# Magnitud: ¿son más fuertes los temblores septembrinos que los de otros meses?

sismos %>%
  ggplot(aes(mes, Magnitud)) +
  geom_jitter(alpha= 0.1) +
  geom_boxplot()

# Frecuencia: ¿son más frecuentes los sismos en septiembre?
sismos %>%
  group_by(mes) %>%
  tally()

