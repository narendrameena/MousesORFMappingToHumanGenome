#@author narumeena
#@description overlaping between tblatn and liftovrr results 


import csv
import pandas as pd
import multiprocessing 

#higConfidentsORFsTblasnREsults_human_Dec14.csv tblatn results 

tblastn = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/higConfidentsORFsTblasnREsults_human_Dec14.csv')

#print(tblastn)
tblastn['sacc']
c= tblastn['sstart']
d= tblastn['send']

#mappedHg19MouseSOrfsCsv  liftover results 

liftOver = pd.read_csv('/Users/naru/Documents/GitHub/MousesORFMappingToHumanGenome/data/mappedHg19MouseSOrfsCsv.csv',header=None)
#print(liftOver)
liftOver[0] #chrom 
a= liftOver[1] #start
b= liftOver[2] #end

#print(a) #j
#print(b) #j
#print(c) #i
#print(d) #i


#print(sORFs)
def mapAll(i):
    for j in range(len(liftOver[0])):
         with open("data/OverlapedsORfsoftblastnAndliftOverHg19.csv",'a') as gh:
            writer= csv.writer(gh)
            if(tblastn['sacc'][i]==liftOver[0][j]):
                if [j] <= c[i] and c[i] <= b[j] and b[j] <= d[i]:
                    if (((b[j]-c[i])*100)/(d[i]-a[j])) > 80:
                        writer.writerow(tblastn.iloc[i].astype(str).tolist() + liftOver.iloc[j].astype(str).tolist())
                    #print(a[j] <= c[i] and c[i] <= b[j] and b[j] <= d[i])
                    #[j] <= c[i] and c[i] <= b[j] and b[j] <= d[i]
                
                if c[i] <= a[j] and a[j] <= d[i] and d[i] <= b[j]:
                    if (((d[i]-a[j])*100)/(b[j]-c[i])) > 80:
                        writer.writerow(tblastn.iloc[i].astype(str).tolist() + liftOver.iloc[j].astype(str).tolist())
                        #c[i] <= a[j] and a[j] <= d[i] and d[i] <= b[j]
                    
                    
                if a[j] <= c[i] and c[i] <= d[i] and d[i] <= b[j]:
                    if (((d[i]-c[i])*100)/(b[j]-a[j])) > 80:
                        writer.writerow(tblastn.iloc[i].astype(str).tolist() + liftOver.iloc[j].astype(str).tolist())
                        #a[j] <= c[i] and c[i] <= d[i] and d[i] <= b[j]
                    
                if c[i] <= a[j] and a[j] <= b[j] and b[j] <= d[i]:
                    if (((b[j]-a[j])*100)/(d[i]-c[i])) > 80:
                        writer.writerow(tblastn.iloc[i].astype(str).tolist() + liftOver.iloc[j].astype(str).tolist())
                #else:
                    #print()
                    #print("do nothing")
                    



pool = multiprocessing.Pool(1000)
zip(*pool.map(mapAll , range(len(tblastn['sacc']))))

#print(tblastn.iloc[2986].astype(str).tolist() + liftOver.iloc[2986].astype(str).tolist())