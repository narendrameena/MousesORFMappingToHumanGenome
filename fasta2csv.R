#@author narumeena
#@description fasta into csv file 

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")


input <- readLines("data/PrabakaransORFsExonic.faa")
output <- file("data/PrabakaransORFsExonic.csv","w")

currentSeq <- 0
newLine <- 0

for(i in 1:length(input)) {
  if(strtrim(input[i], 1) == ">") {
    if(currentSeq == 0) {
      writeLines(paste(input[i],"\t"), output, sep="")
      currentSeq <- currentSeq + 1
    } else {
      writeLines(paste("\n",input[i],"\t", sep =""), output, sep="")
    }
  } else {
    writeLines(paste(input[i]), output, sep="")
  }
}

close(output)