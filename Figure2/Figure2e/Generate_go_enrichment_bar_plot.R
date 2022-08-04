library(ggplot2)

df <- read.csv("variable_table2.tsv", header=T, sep="\t", stringsAsFactors=F)
df_rank <- df[order(df$FDR),]
df_rank <- head(df_rank, 10)
df_rank

g <- ggplot(df_rank, aes(x=reorder(df_rank$Description, (Number.in.input.list)), y=Number.in.input.list)) +
  geom_bar(stat='identity', fill="skyblue", color="black") +
#  scale_y_break(c(15000, 25000)) +
  labs(x="", y="Gene number") +
  theme(panel.background = element_blank(),
        strip.background = element_rect(fill="white", colour="black"),
        axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.x = element_text(size=15, color="black"),
        axis.text.y = element_text(size=15, color="black"),
        axis.title.x = element_text(size=15)
        ) +
  scale_y_continuous(labels = scales::comma, limits=c(0, NA), expand = c(0, 0)) +
  coord_flip()

g

png(filename="variable_whole.png",width=800,height=600)
g
dev.off()

