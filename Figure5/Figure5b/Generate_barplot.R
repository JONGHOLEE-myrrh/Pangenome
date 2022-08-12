library(ggplot2)

df <- read.csv("ForBarPlot.tsv", header=T, sep="\t", stringsAsFactors=F)
head(df)
df_rank <- df[rev(order(df$NUMBER)),]
df_rank <- head(df_rank, 10)
df_rank

ggplot(df_rank, aes(x=reorder(df_rank$DESCRIPTION, (NUMBER)), y=NUMBER)) +
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
  geom_text(aes(label=ID), hjust=1, size=5)+
  scale_y_continuous(labels = scales::comma, limits=c(0, NA), expand = c(0, 0)) +
  coord_flip()

png(filename="core_whole.png",width=800,height=600)
g
dev.off()

