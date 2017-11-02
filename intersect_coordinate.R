#install if necessary
source("http://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")

#load library
library(GenomicRanges)

#create a GRanges object given an object, my_refseq_loci
sORfs3604 <- read.delim("data/mappedHg38MouseSOrfs3604.txt", header = F)

head(sORfs3604)
#   refseq_mrna chromosome_name transcript_start transcript_end strand
#1 NM_001084392           chr22         24313554       24316773      -
#2    NM_001355           chr22         24313554       24322019      -

my_refseq_gr <- with(sORfs3604,
                        GRanges(sORfs3604$V1,
                                IRanges(sORfs3604$V2, sORfs3604$V3),
                                sORfs3604$V4
                        )
                      )
my_refseq_gr
#GRanges with 33584 ranges and 0 metadata columns:
#               seqnames                 ranges strand
#                  <Rle>              <IRanges>  <Rle>
#  NM_001084392    chr22   [24313554, 24316773]      -
#     NM_001355    chr22   [24313554, 24322019]      -
#     NM_138450    chr13   [50202435, 50208008]      +
#     NM_022840    chr18   [ 2538452,  2571485]      -
#     NM_033453    chr20   [ 3190006,  3204516]      +
#           ...      ...                    ...    ...
#     NM_170783     chr6 [ 30029031,  30032686]      +
#     NM_014596     chr6 [ 30029036,  30032686]      +
#     NM_144600    chr16 [ 15959577,  15982472]      -
#     NM_173689     chr9 [126118539, 126141032]      +
#     NM_021959     chr6 [ 30034865,  30038110]      +
#  ---
#  seqlengths:
#    chr1 chr10 chr11 chr12 chr13 chr14 chr15 ...  chr6  chr7  chr8  chr9  chrX  chrY
#      NA    NA    NA    NA    NA    NA    NA ...    NA    NA    NA    NA    NA    NA

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
table((my_random_gr, my_refseq_gr))

#    0     1     2     3     4     5     6     7     8     9    10    11    12    13 
#41077  4955  2014   965   414   218   138    68    43    30    25     7    14    11 
#   14    15    16    17    20    21    22    23    28    31 
#    3     1     1     3     4     1     1     5     1     1

#store overlap
my_overlap <- countOverlaps(my_random_gr, my_refseq_gr)

#how many overlaps
table(my_overlap>0)

#FALSE  TRUE 
#41077  8923

#remove the overlapping ids from my_random_loci
sORfs3604 <- sORfs3604[my_overlap>0,]

write.csv(sORfs3604, file = "data/OverlapsORFs.txt")

head(sORfs3604)
#check the dimensions
dim(sORfs3604)
#[1] 41077     4