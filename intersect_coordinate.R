#install if necessary
source("http://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")

#load library
library(GenomicRanges)

setwd("/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome")

#create a GRanges object given an object, my_refseq_loci
sORfs3604 <- read.delim("data/mappedHg38MouseSOrfs3604.txt", header = F)

head(sORfs3604)

my_refseq_gr <- with(sORfs3604,
                        GRanges(sORfs3604$V1,
                                IRanges(sORfs3604$V2, sORfs3604$V3),
                                sORfs3604$V4
                        )
                      )
my_refseq_gr


sORF8175 <- read.delim("data/mappedHg38MouseSOrfs.txt", header = F)

head(sORF8175)

#create another GRanges object
my_random_gr <- with(sORF8175,
                     GRanges(sORF8175$V1,
                             IRanges(sORF8175$V2, sORF8175$V3),
                             sORF8175$V4
                             )
                        )

#how many overlap?
#table((my_random_gr, my_refseq_gr))


my_overlap <- countOverlaps(my_random_gr, my_refseq_gr)

#how many overlaps
table(my_overlap>0)

sORfs3604 <- sORfs3604[my_overlap>0,]

write.csv(sORfs3604, file = "data/OverlapsORFs.txt")

head(sORfs3604)
#check the dimensions
dim(sORfs3604)
#[1] 41077     4