#@author narumeena
#@description using cosmic ids to get disease 

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")

cosmicMutationOnsORFs <- read.csv("data/mapPrallelCosmic.csv",header = F)
head(cosmicMutationOnsORFs$V3)

cosmicsDisease <- read.delim("data/CosmicNCV.tsv", header = TRUE  )
head(cosmicsDisease)

data<- cosmicsDisease[c(as.character(cosmicsDisease$ID_NCV)) %in% c(as.character(cosmicMutationOnsORFs$V3)) ,]
data$ID_NCV
write.csv(data,file="data/cosmicNonCodMutationDisease.csv")

data <-read.csv("data/cosmicNonCodMutationDisease.csv",header = T)
data$ID_NCV
data$Primary.site
