#@author narumeena
#@description maping mutations to sORfs

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")

mutation <- read.csv("data/egHGMD.csv", header = TRUE)

head(mutation)

#add chr to every chromosome 
mutation$X.CHROM <- paste("chr", mutation$X.CHROM, sep="")


sORFs <- read.csv("data/mappedHg38MouseSOrfs.txt", header = TRUE,sep=",")

s

head(sORFs )

mutation$X.CHROM[1]

for(i in 1:length(mutation$X.CHROM )){
  #print(i)
  
for (j in 1:length(sORFs$V1)){
  if( mutation$X.CHROM[i] %in% sORFs$V1[j]){
    #print(mutation$X.CHROM[i])
    #print(sORFs$V1[j])
    #print(sORFs$V2[i])
    #print(mutation$POS[i])
    #print(sORFs$V3[i])
    if(sORFs$V2[j] <= mutation$POS[i] & mutation$POS[i]<= sORFs$V3[j]){
      print(paste(sORFs$V2[j] , mutation$POS[i] , sORFs$V3[j] , sep = ","))
      
    }
  }
}
}

#head(sORFs)
