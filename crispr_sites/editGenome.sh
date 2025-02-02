#!/bin/bash

#Goal: Inserts "A" nucleotide one base upstream from CRISPR site (NGG) in each fasta file in preCrispr directory,
#and moves files to postCrispr directory.
#Author: Ondine Grosser

mkdir postCrispr #Creates postCrispr directory
str='_postcrispr' #Stores part of output FASTA name in variable str

for file in preCrispr/*.fasta
do
    n="${file#*/}" #Part of above file name without the path
    name="${n%%_*}" #Creates name variable that is just the sample code name

    #Creates a backup of FASTA file in preCrispr directory, rewrites over the original FASTA by inserting "A" one base upstream from NGG 
    sed -i.bak 's/\([ACGT]GG\)/A\1/g' $file
    mv $file $name$str.fasta #Renames rewritten FASTA file
    mv preCrispr/*.bak $file #Renames backup FASTA file to original name
    mv $name$str.fasta postCrispr #Moves new FASTA file to postCrispr directory
done

