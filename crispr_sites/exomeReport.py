#Goal: Generates summarized report in text file
#Author: Ondine Grosser
import csv #Module allows for reading tab-delimited files
import os #Module allows for operating system interaction

path = "./exomesCohort" #Sets path variable as exomesCohort directory
dir_list = os.listdir(path) #Reads file names in exomesCohort to a list
i = 0 #Index equals 0
for f in dir_list: #Loops through each file name in dir_list
    f = f.replace('.fasta','') #Replaces ".fasta" in each file name with empty string
    dir_list[i] = f #Sets list value at current index as just the sample name
    i = i + 1 #Increases index by 1

adict = {} #Creates empty dictionary adict
with open('data/clinical_data.txt', 'r') as f: #Opens clinical_data.txt in read mode
    reader=csv.reader(f, delimiter='\t') #Reads through clinical_data.txt without tab seperator
    for row in reader: #For each row in clinical_data.txt
        for name in dir_list: #For each sample name in dir_list
            if name in row: #If the current row contains the sample name
                #Sets adict key to sample name and adict value to a list containing the current row
                adict['%s' % name] = row

o = open('report.txt', 'w') #Creates empty report.txt file. Overwrites existing file
o.close()

for name in adict: #For each sample name in dictionary adict
    exome = adict[name] #The adict value associated with each sample name
    gene = open('./postCrispr/%s_postcrispr.fasta' % name, 'r') #Opens each postcrispr.fasta file in read mode
    line1 = gene.readline() #Reads first line
    line2 = gene.readline() #Reads second line
    with open('report.txt', 'a') as r: #Opens the text file for the report in append mode
        #Appends sentences to report file and assigns corresponding variables for each sample name
        r.write("Organism %s, discovered by %s, has diameter of %s, and from the environment %s.\n" % (name.upper(), exome[0].upper(), exome[2], name.upper())
              + "The list of genes can be found in: ./postCrispr/%s_postcrispr.fasta\n" % (name.upper())
              + "The first sequence of %s is:\n" % (name.upper())
              + "\n%s\n%s\n" % (line1, line2))
    r.close() #Closes report.txt


