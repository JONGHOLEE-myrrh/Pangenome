library(ggplot2)
library(dplyr)
library(plyr)

df <- read.csv("Orthogroups.GeneCount.tsv", sep="\t", stringsAsFactors=F)
head(df)
str(df)

df_filt <- subset(df, select=-c(Orthogroup, Total))
df_filt[df_filt == 0] <- NA
df_filt[df_filt >= 1] <- 1
total <- rowSums(df_filt, na.rm=TRUE)
df_filt_merge <- cbind(df_filt, total)
str(df_filt_merge)
head(df_filt_merge)

# Number of core orthogroups.
df_core <- na.omit(subset(df_filt_merge, select=-c(total)))
str(df_core)
df_core_sum <- colSums(df_core)
df_core_sum

# Number of specific orthogroups.
df_specific <- df_filt_merge %>%
  filter(df_filt_merge$total == 1)
df_specific <- subset(df_specific, select=-c(total))
df_specific_sum <- colSums(df_specific, na.rm=TRUE)
df_specific_sum

# Number of variable orthogroups(2 <= No. of common orthogroups <= 11).
df_variable <- df_filt_merge %>% filter(2 <= df_filt_merge$total & df_filt_merge$total <= 11)
df_variable <- subset(df_variable, select=-c(total))
df_variable_sum <- colSums(df_variable, na.rm=TRUE)
df_variable_sum


data <- rbind(df_core_sum, df_variable_sum, df_specific_sum)
data

df <- data.frame(
  accessions = rep(c("CC090","CC260","CV3","Dempsey","I19-702-1","LaMuyo-01","MR","Maor","PG1","Perennial","ThaiHot","UCD10X"), 3),
  values     = c(data[1,], data[2,], data[3,]),
  status     = c(rep(c("core"), 12), rep(c("variable"), 12), rep(c("specific"), 12))
)
df

ggplot(df, aes(x=accessions, y=values, fill=status)) +
  geom_col(stat="identity", colour="black", position = position_stack(reverse=TRUE)) +
  labs(x="", y="Gene families") +
  theme(panel.background = element_blank(),
        strip.background = element_rect(fill="white", colour="black"),
        axis.line        = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.x      = element_text(size=15, color="black", angle=315),
        axis.text.y      = element_text(size=15, color="black"),
        axis.title.y     = element_text(size=15),
        legend.title     = element_text(size=15),
        legend.text      = element_text(size=15)
        ) +
  scale_y_continuous(labels = scales::comma, limits=c(0, NA), expand = c(0, 0)) +
  geom_text(aes(label=values), size = 5, position = position_stack(vjust=0.5, reverse=TRUE))

