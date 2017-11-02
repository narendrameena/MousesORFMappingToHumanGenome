#@author narumeena
#@description maping mutations to sORfs

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")

mutation <- read.delim("data/CosmicNonCodingVariants.txt", header = TRUE)

#head(mutation)

#add chr to every chromosome 
mutation$X.CHROM <- paste("chr", mutation$X.CHROM, sep="")
sORFs <- read.delim("data/mappedHg38MouseSOrfs.txt", header = FALSE)

#head(sORFs )

mutation$X.CHROM[1]

for(i in 1:length(mutation$X.CHROM )){
  #print(i)
  

  if( mutation$X.CHROM[i] %in% sORFs$V1[i]){
    #print(mutation$X.CHROM[i])
    #print(sORFs$V1[i])
    #print(sORFs$V2[i])
    #print(mutation$POS[i])
    #print(sORFs$V3[i])
    if(sORFs$V2[i] <= mutation$POS[i] & mutation$POS[i]<= sORFs$V3[i]){
      print(paste(sORFs$V2[i] , mutation$POS[i] , sORFs$V3[i] , sep = ","))
    }
  }
  
}

#head(sORFs)
