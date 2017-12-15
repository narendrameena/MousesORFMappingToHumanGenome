#author narumeena
#description plots from diffrential expression analysisis


setwd("/Users/naru/Documents/BISR/CPC4Result")
#source("https://bioconductor.org/biocLite.R")
#biocLite("Formula")
library(cummeRbund)

#Create a CummeRbund database from the Cuffdiff output
cuff_data <- readCufflinks("cuffdiff")

# Plot the distribution of expression levels for each sample
csDensity(genes(cuff_data))

#Compare the expression of each gene in two conditions with a scatter plot
csScatter(genes(cuff_data), 'AP4', 'CPC4')

#Create a volcano plot to inspect differentially expressed genes 
csVolcano(genes(cuff_data), 'AP4', 'CPC4')

#Plot expression levels for genes of interest with bar plots 
mygene < - getGene(cuff_data, 'regucalcin')
expressionBarplot(mygene)

#Plot individual isoform expression levels of selected genes of interest with bar plots 
expressionBarplot(isoforms(mygene))

#You can use CummeRbund to quickly inspect the number of genes and transcripts that
#are differentially expressed between two samples
cuff_data
gene_diff_data <- diffData(genes(cuff_data))
sig_gene_data <- subset(gene_diff_data, (significant == 'yes'))
nrow(sig_gene_data)

#Similar snippets can be used to extract differentially expressed transcripts or
#differentially spliced and regulated genes

isoform_diff_data < - diffData(isoforms(cuff_data), 'AP4', 'CPC4')
sig_isoform_data < - subset(isoform_diff_data, (significant == 'yes'))
nrow(sig_isoform_data)
tss_diff_data < - diffData(TSS(cuff_data), 'AP4', 'CPC4')
sig_tss_data < - subset(tss_diff_data, (significant == 'yes'))
nrow(sig_tss_data)
cds_diff_data < - diffData(CDS(cuff_data), 'AP4', 'CPC4')
sig_cds_data < - subset(cds_diff_data, (significant == 'yes'))
nrow(sig_cds_data)
promoter_diff_data < - distValues(promoters(cuff_data))
sig_promoter_data < - subset(promoter_diff_data, (significant == 'yes'))
nrow(sig_promoter_data)
splicing_diff_data < - distValues(splicing(cuff_data))

sig_splicing_data < - subset(splicing_diff_data, (significant == 'yes'))
nrow(sig_splicing_data)
relCDS_diff_data < - distValues(relCDS(cuff_data))
sig_relCDS_data < - subset(relCDS_diff_data, (significant == 'yes'))
nrow(sig_relCDS_data)

#The code above can also be modified to write out small files containing only the
#differentially expressed genes. These files may be more manageable for some spreadsheet
#software than the full output files produced by Cuffdiff. 

gene_diff_data < - diffData(genes(cuff_data))
sig_gene_data < - subset(gene_diff_data, (significant == 'yes'))
write.table(sig_gene_data, 'diff_genes.txt', sep = 't', row.names = F,col.names = T, quote = F)
