#!/bin/bash

#Goal: Identify samples from /home/rbif/week3/clinical_data.txt that have a diameter between 20 and 30 mm and are sequenced,
#and copy the FASTA files for each sample to the exhomesCohort directory.
#Author: Ondine Grosser

cp -r data/clinical_data.txt . #Copy clinical_data.txt file to current directory.
mkdir exomesCohort #Create exomesCohort directory.

#Outputs each sample from clinical_data.txt that has a diameter between 20-30mm and are sequenced to temp file name.txt.
echo "$(awk -F '\t' '(($3 >= "20") && ($3 <= "30") && ($5 == "Sequenced")) {print $6}' clinical_data.txt)" >> name.txt
while read -r line
do
    cp -r data/exomes/$line.fasta exomesCohort #Copies FASTA files for samples in name.txt to exomesCohort directory.
done < name.txt
rm name.txt clinical_data.txt #Removes temp file and clinical data file.