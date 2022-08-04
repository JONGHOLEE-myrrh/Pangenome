library(ggplot2)

data <- read.table("Ortholog_list.txt", header=TRUE, sep="\t")
head(data)
data$Genomes <- as.factor(data$Genomes)

p <- ggplot(data, aes(x=Genomes, y=Orthologs, fill=Status)) +
  geom_boxplot() +
  theme_test()
p

png(filename="pan_genome_plot.png",width=800,height=600)
p
dev.off()
