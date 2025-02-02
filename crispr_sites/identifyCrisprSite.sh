#!/bin/bash

#Goal: Identify suitable CRISPR sites in each gene in each topmotif FASTA file in topmotifs directory,
#outputs corresponding headers and sequences to a new fasta file, and moves said files to a preCrispr directory.
#CRISPR site is NGG where N is any nucleotide.
#Author: Ondine Grosser

mkdir preCrispr #Creates preCrispr directory
str='_precrispr' #Stores part of output FASTA name in variable str

for file in topmotifs/*.fasta #For each FASTA file in the topmotifs directory
do
    n="${file#*/}" #Part of above file name without the path
    name="${n%%_*}" #Creates name variable that is just the sample code name
    touch $name$str.fasta #Creates new FASTA files for each sample

    grep -E '[ACGT]{20,}(GG:?)' $file >> $name.fasta #Outputs lines that have GG at least 21 base pairs downstream
    while read -r line #Reads each line of temp fasta file
    do
        grep -B 1 $line $file | grep -v "^--" >> $name$str.fasta #Outputs gene name and sequence to new FASTA file
    done < $name.fasta
    
    rm $name.fasta #Removes temp FASTA file
    mv $name$str.fasta preCrispr #Moves new FASTA files to preCrispr directory
    
done