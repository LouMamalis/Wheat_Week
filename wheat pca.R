library(tidyverse) 
library(Rtsne)

# import data note the file does not include column names
file <- "data-raw/seeds_dataset.txt"

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

#the species codes are 1, 2 and 3 so to make it more useful you can change them to the names of the species instead
seeds$species <- recode(seeds$species,
                        `1` = "Kama",
                        `2` = "Rosa",
                        `3` = "Canadian")

#can plot the variables pairwise against each other
#can look at all these plots and see which ones have the least overlap - which can be used to distinguish the different seed species from each other
#area and perimeter look the most different between species. 
seeds %>% 
  GGally::ggpairs(aes(color = species)) 

#make the pca dataframe
pca <- seeds %>% 
  select(-species) %>% 
  prcomp(scale. = TRUE)

#create the summary of the pca to look at the variance 
#PC1 shows the 71.87%
summary(pca)
