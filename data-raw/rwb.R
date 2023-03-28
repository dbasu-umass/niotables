# libraries
library(tidyverse)
library(readxl)
library(readr)

# --- IO Data for real wage bundle
rwb <- read_excel(
  path="~/MyRProjects/niotables/data-raw/USA_NIOT_nov16.xlsx",
  sheet = "National IO-tables"
) %>%
  dplyr::filter(
    Origin=="Domestic"
  ) %>%
  dplyr::select(
    c("Year","Code","CONS_h")
  ) %>%
  as.data.frame()

save(rwb, file = "data/rwb.rda", compress = "xz")
