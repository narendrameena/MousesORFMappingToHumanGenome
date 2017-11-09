#author narumeena
#description map mutation to sORFs

import csv
import pandas as pd
import multiprocessing 

mutations = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/HGMD_PRO_2016.4_hg19Csv.csv')

mutations['#CHROM'] = 'chr' + mutations['#CHROM'].astype(str)
#print(mutations['POS'])

sORFs = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/mappedHg19MouseSOrfsCsv.csv', header=None)

#print(sORFs)
def mapAll(i):
    for j in range(len(sORFs[0])):
         with open("data/mapPrallelHGMD.csv",'a') as gh:
            writer= csv.writer(gh)
            if(mutations['#CHROM'][i]==sORFs[0][j]):
                if sORFs[1][j] <= mutations['POS'][i] <= sORFs[2][j]:
                    writer.writerow([mutations['#CHROM'][i]+',' + str(mutations['POS'][i]) +',' + sORFs[0][j]+',' + str(sORFs[1][j])+',' + str(sORFs[2][j])])




pool = multiprocessing.Pool(4)
zip(*pool.map(mapAll, range(len(mutations['#CHROM']))))
