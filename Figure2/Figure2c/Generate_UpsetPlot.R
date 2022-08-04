install.packages("UpSetR")


library(UpSetR)

df <- read.csv("Orthogroups.GeneCount.tsv", header=TRUE, sep="\t")
head(df)
str(df)

#df_pun <- subset(df, select=c(CC090.final.PEP, CC260.final.PEP, MR3.final.PEP, Perennial.final.PEP, ThaiHot.final.PEP, CV3.final.PEP))
df_filt <- subset(df, select=-c(Orthogroup, Total))
df_filt[df_filt >= 1] <- 1
head(df_filt)
str(df_filt)

#df_core <- df_filt %>% filter(rowSums(df_filt) == 12)
df_near_core <- df_filt %>% filter(rowSums(df_filt) >= 11)

df_pun1 <- df_filt %>% 
  filter((rowSums(df_filt) == 6))
df_pun1

df_2 <- rbind(df_core, df_near_core)
head(df_2)
str(df_2)

accessions <- colnames(df_2)
accessions

#df_2[accessions] = df_2[accessions] == 1
#df_2 <- as.matrix(df_2)
#df_2
#df_3 <- t(head(df_2[accessions], 30))
#df_3

upset(df_near_core, sets=accessions, order.by="freq", text.scale=2, mainbar.y.label="Gene families", point.size = 3.6, sets.x.label = "")
