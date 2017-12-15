

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/")
library(data.table)

overlap <- read.table("OverlapedsORfsoftblastnAndliftOverHg38.csv",sep=",", header=F)
head(overlap) 



df[c("V17","V18")]
HGMDcount  <- read.table("mapHGMDMuatationsOverOvelapedLiftOverandTblastREsultsSORFsHG19.csv",sep=",", header=F)
head(HGMDcount)

HGMDcount$V14

HGMDregions <- overlap[overlap$V4 %in% unique(c(as.character(HGMDcount$V14))),]

length(unique(HGMDregions$V4))
write.csv(HGMDregions, file = "HGMDMutationsORFsregions.csv")
