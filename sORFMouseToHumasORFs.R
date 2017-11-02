#@author narumeena
#@description change mouse sORfs corrdinate to human sORFs coordinate 
setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")
sORfsMouse <- read.delim("data/8175_sorfs_info.txt", header = FALSE)
head(sORfsMouse) 

sORfsMouse$allData <-  paste(sORfsMouse$V5, sORfsMouse$V6,sORfsMouse$V7,sORfsMouse$V8, sep = ",")

#write.csv(sORfsMouse, file = "data/inputMousesORf.txt")
#install bedr
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("bedr")


command <- "tool/liftOverOSX data/inputMousesORf.txt data/mm10ToHg38.over.chain data/mappedHg38MouseSOrfs.txt data/unmappedHg38MouseSOrfs.txt"

#run the command 
system(command, intern = FALSE,
       ignore.stdout = FALSE, ignore.stderr = FALSE,
       wait = TRUE, input = NULL, show.output.on.console = TRUE,
       minimized = FALSE, invisible = TRUE, timeout = 0)