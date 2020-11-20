library(tidyverse) 
library(Rtsne)

# import data note the file does not include column names
file <- "../data-raw/seeds_dataset.txt"

# create column names
cols <- c("area", 
          "perimeter",
          "compactness",
          "kernal_length",
          "kernel_width",
          "asymmetry_coef",
          "groove_length",
          "species")

# import data
seeds <- read_table2(file, col_names = cols)

# The species is coded as 1, 2, and 3 and it would be useful to recode to the species names:
seeds$species <- recode(seeds$species,
                        `1` = "Kama",
                        `2` = "Rosa",
                        `3` = "Canadian")