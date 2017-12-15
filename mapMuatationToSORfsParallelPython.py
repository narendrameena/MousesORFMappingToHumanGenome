#author narumeena
#description map mutation to sORFs

import csv
import pandas as pd
import multiprocessing 

mutations = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/HGMD_PRO_2016.4_hg19Csv.csv')

mutations['#CHROM'] = 'chr' + mutations['#CHROM'].astype(str)
#print(mutations['POS'])

sORFs = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/OverlapedsORfsoftblastnAndliftOverHg19.csv', header=None)

print(sORFs)
#print(sORFs)
def mapAll(i):
    for j in range(len(sORFs[0])):
         with open("data/mapHGMDMuatationsOverOvelapedLiftOverandTblastREsultsSORFsHG19.csv",'a') as gh:
            writer= csv.writer(gh)
            if(mutations['#CHROM'][i]==sORFs[12][j]):
                if sORFs[16][j] <= mutations['POS'][i] <= sORFs[17][j]:
                    writer.writerow(mutations.iloc[i].astype(str).tolist() + sORFs.iloc[j].astype(str).tolist())



pool = multiprocessing.Pool(1000)
zip(*pool.map(mapAll, range(len(mutations['#CHROM']))))
