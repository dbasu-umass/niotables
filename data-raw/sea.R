# libraries
library(tidyverse)
library(readxl)
library(readr)

# --------- Read SEA data
# Source: WIOD 2016 Release
d1_1 <- readxl::read_excel(
  path="~/MyRProjects/niotables/data-raw/WIOD_SEA_Nov16.xlsx",
  sheet = "DATA"
) %>% 
  dplyr::select(-description) %>%
  pivot_longer(
    !c("country", "variable", "code"),
    names_to = "year",
    values_to = "value"
  ) %>%
  pivot_wider(
    names_from = "variable",
    values_from = "value"
  ) %>%
  as.data.frame()

# ------- Read Nominal Exchange Rate data
# Source: OECD
d1_2 <- readxl::read_excel(
  path="~/MyRProjects/niotables/data-raw/Exchange_Rates_OECD.xlsx"
) %>%
  mutate(
    year = as.character(TIME)
  ) %>%
  as.data.frame()

# ------- Merge the two data sets
sea <- left_join(d1_1, d1_2, by = c("country", "year"))

write_csv(sea, "data-raw/sea.csv")
save(sea, file = "data/sea.rda")