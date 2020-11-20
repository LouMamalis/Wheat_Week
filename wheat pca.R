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
#PC1 shows the 71.87% of the variance 
#cumulatively the first three PCs account for 98.668% of the variance 
summary(pca)

#looking at the loadings of each of the PCs
#each PC is a line on the axis and how the variables influence that line
#negative values does not really make a difference - absolute size determines how important the variable is
#PC1 = determined by area and perimeter the most
#PC2 = determined by asymmetry_coef and compactness
pca$rotation

#extract the scores from pca using $x, the scores are stored in x
#can put these into a dataframe
pca_labelled <- data.frame(pca$x, species = seeds$species)

#created a scatterplot for PC1 and PC2 
ggplot(pca_labelled, aes(x = PC1, y = PC2, color = species)) +
  geom_point()

#do not do this, choose 1 and 2
#PC6 and PC7 give results that are more overlapping and less distinct 
#ggplot(pca_labelled, aes(x = PC6, y = PC7, color = species)) +
  geom_point()
