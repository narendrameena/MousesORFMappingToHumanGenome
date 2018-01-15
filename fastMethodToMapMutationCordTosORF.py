#@author narumeena
#@description  fast mapping of chrom cords 


import csv
import pandas as pd
import multiprocessing 
from joblib import Parallel, delayed




#vcf file, list of mutation 

vcfMutation                 = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/SourceData/CosmicNonCodingVariants-14-12-17-SP.vcf',delimiter='\t', dtype='unicode',skiprows=13)
vcfMutation["#CHROM"]       = 'chr' + vcfMutation["#CHROM"].astype(str)
chromList                   = vcfMutation["#CHROM"].unique()

#print(vcfMutation)

#mutationChrom = pd.DataFrame()
#sORfsChrom    = pd.DataFrame()
#print(vcfMutation.loc[vcfMutation['#CHROM'] == 'chr1'])



#sORFs file, list of sORFS 
sORFs = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/SourceData/human_PLsorf_database.txt',delimiter='\t', dtype='unicode')

#print(sORFs)

#print(sORFs.Chromosome.unique())

num_cores = multiprocessing.cpu_count()
    
#results = Parallel(n_jobs=num_cores)(delayed(processInput)(i) for i in inputs)

def mappingMutation(mut,sORfsChrom, mutationChrom):
    for orf in range(len(sORfsChrom.Chromosome)):
        #print(sORfsChrom)
        with open('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/resultData/CosmicNonCodingVariantsMappedToHumansORFs.csv', 'a') as gh:
            writer = csv.writer(gh)
            if(mutationChrom['#CHROM'][mut]==sORfsChrom.Chromosome[orf]):
                if(float( sORfsChrom.Start_position[orf]) <= float( mutationChrom.POS[mut]) <= float( sORfsChrom.End_position[orf])):
                    print(mutationChrom.iloc[mut].astype(str).tolist() + sORfsChrom.iloc[orf].astype(str).tolist())
                    writer.writerow(mutationChrom.iloc[mut].astype(str).tolist() + sORfsChrom.iloc[orf].astype(str).tolist())
                
            
        gh.close()

pool = multiprocessing.Pool(1000)

#Loop for chromosomes 
for chrom in chromList:
    mutationChrom   = vcfMutation.loc[vcfMutation['#CHROM'] == chrom]
    sORfsChrom      = sORFs.loc[sORFs['Chromosome'] == chrom]
    #print(sORfsChrom.Chromosome )
    #for mut in range(len(mutationChrom['#CHROM'])):
    #zip(*pool.map(mappingMutation, range(len(mutationChrom['#CHROM']))))
    Parallel(n_jobs=100)(delayed(mappingMutation)(mut,sORfsChrom, mutationChrom ) for mut in range(len(mutationChrom.POS)))
        
    #print(chrom) 


#result = sORFs[(sORFs.Start_position<=vcfMutation.POS )&(sORFs.End_position>=vcfMutation.POS)&(sORFs.Chromosome==vcfMutation['#CHROM'])]