#!/bin/bash

#Goal: Identifies the three highest occurring motifs from /home/rbif/week3/motif_list.txt in each exome in exomesCohort directory,
#outputs corresponding headers and sequences to new FASTA files and moves said files to a topmotifs directory.
#Author: Ondine Grosser

cp -r data/motif_list.txt . #Copies motif_list.txt file to current directory.
mkdir topmotifs #Creates topmotifs directory.
str='_topmotifs' #Stores part of output FASTA file names as variable str

for file in exomesCohort/*.fasta #For each file in exomesCohort directory that ends with .fasta
do
    name="$(basename -s .fasta "$file")" #Creates name variable that is the sample code name
    while read -r line #Reads each line in motif_list.txt
    do
        c=$(grep -o $line $file | wc -l) #Counts number of occurances of each motif in exome files in exomesCohort directory
        echo "$line $c" >> count.txt #Outputs motifs and number of occurances in temp file count.txt
    done < motif_list.txt
    #Sorts motifs in count.txt by ascending order, then outputs the three with the most occurances to temp file top.txt
    cat count.txt | sort -n -k2 | tail -n 3 > top.txt
    rm count.txt #Removes count.txt temp file
    m1=$(awk 'NR == 1 {print $1}' top.txt) #Sets variable as first motif in top.txt
    m2=$(awk 'NR == 2 {print $1}' top.txt) #Sets variable as second motif in top.txt
    m3=$(awk 'NR == 3 {print $1}' top.txt) #Sets variable as third motif in top.txt
    rm top.txt #Removes top.txt temp file

    grep -E "$m1|$m2|$m3" $file >> $name.fasta #Outputs lines where one of the three motifs occur to temp FASTA file
    while read -r line #Reads each line of temp FASTA file
    do
        grep -B 1 $line $file | grep -v "^--" >> $name$str.fasta #Outputs gene name and sequence to new FASTA file
    done < $name.fasta

    rm $name.fasta #Removes temp file
    mv $name$str.fasta topmotifs #Moves new FASTA files to topmotifs directory
done
rm motif_list.txt #Removes motif_list.txt
