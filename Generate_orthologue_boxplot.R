library(ggplot2)

data <- read.table("Core_2.txt", header=TRUE, sep="\t")
head(data)
data$Genomes <- as.factor(data$Genomes)

p <- ggplot(data, aes(x=Genomes, y=Orthologs, fill=Status)) +
  geom_boxplot() +
  theme_test()
p
