###task 2###
file <- "data-raw/sol.txt"
sol <- read_table2(file)
names(sol)

tsol <- sol %>% 
  select(-genename) %>% 
  t() %>% 
  data.frame()

names(tsol) <- sol$genename

tsol$sample <- row.names(tsol)

tsol <- tsol %>% 
  extract(sample, 
          c("lineage","rep"),
          "(Y[0-9]{3,4})\\_([A-C])")

pca <- tsol %>% 
  select(-lineage, -rep) %>%
  prcomp(scale. = TRUE)

summary(pca)

pca_labelled <- data.frame(pca$x, lineage = tsol$lineage)

tsne <- tsol %>% 
  select(-lineage, -rep) %>%
  Rtsne(perplexity = 4,
        check_duplicates = FALSE)

dat <- data.frame(tsne$Y,  lineage = tsol$lineage)

dat %>% ggplot(aes(x = X1, y = X2, colour = lineage)) +
  geom_point()

