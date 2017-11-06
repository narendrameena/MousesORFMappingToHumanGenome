#@author narumeena
#@description maping mutations to sORfs in parallel 

library(foreach)
library(doParallel)

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")

mutation <- read.delim("data/CosmicNonCodingVariants.txt", header = TRUE)

#head(mutation)

#add chr to every chromosome 
mutation$X.CHROM <- paste("chr", mutation$X.CHROM, sep="")


sORFs <- read.delim("data/mappedHg38MouseSOrfs.txt", header = FALSE)

#head(sORFs )

#mutation$X.CHROM[1]


#function in R 

mapMutTOsORF <- function(i){
  print(i)
  for (j in 1:length(sORFs$V1)){
    if( mutation$X.CHROM[i] %in% sORFs$V1[j]){
      print(mutation$X.CHROM[i])
      print(sORFs$V1[i])
      print(sORFs$V2[i])
      print(mutation$POS[i])
      print(sORFs$V3[i])
      if(sORFs$V2[j] <= mutation$POS[i] & mutation$POS[i]<= sORFs$V3[j]){
        print(paste(mutation$X.CHROM[i], sORFs$V1[j], sORFs$V2[j] , mutation$POS[i] , sORFs$V3[j] , sep = ","))
        return(paste(mutation$X.CHROM[i], sORFs$V1[j], sORFs$V2[j] , mutation$POS[i] , sORFs$V3[j] , sep = ","))
        
      }
    }
  }
  
}

#setup parallel backend to use many processors
cores=detectCores()
cl <- makeCluster(cores[1]-1) #not to overload your computer
registerDoParallel(cl)



foreach(i=1:length(mutation$X.CHROM), .combine=cbind) %dopar% {
  tempMatrixOfMutMappedTosORFs = mapMutTOsORF(i)
  
  ## write results to disk
  file=paste0(tempMatrixOfMutMappedTosORFs,"/results_",i,".csv")
  write.csv(results,file=file)
  return(NULL)
  }
#stop cluster
stopCluster(cl)
