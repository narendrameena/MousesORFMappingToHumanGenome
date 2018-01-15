

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/")
library(data.table)

overlap <- read.table("OverlapedsORfsoftblastnAndliftOverHg19.csv",sep=",", header=F)
head(overlap) 

length(overlap$V5)
length(unique(overlap$V5))



df[c("V17","V18")]
HGMDcount  <- read.table("map",sep=",", header=F)
head(HGMDcount)

length(HGMDcount$V9)

HGMDregions <- overlap[overlap$V4 %in% unique(c(as.character(HGMDcount$V14))),]

length(unique(HGMDregions$V9))
write.csv(HGMDregions, file = "HGMDMutationsORFsregions.csv")
