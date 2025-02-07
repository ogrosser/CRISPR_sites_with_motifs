# CRISPR_sites_with_motifs
This project identifies suitable CRISPR gene candidates for a list of organisms
that contain the most abundant motifs that are associated with hypothetical gamma ray resistance.

The inputs for this script are:

data/clinical_data.txt

data/motif_list.txt

data/exomes/*.fasta

The outputs for this script are:

exomesCohort directory -> contains FASTA files of exomes that meet set criteria

topmotifs directory -> contains topmotifs.fasta files

preCrispr directory -> contains precrispr.fasta files

postCrispr directory -> contains postcrispr.fasta files

{exomename}_topmotifs.fasta -> output from createCrisprReady.sh

{exomename}_precrispr.fasta -> output from identifyCrisprSite.sh

{exomename}_postcrispr.fasta -> output from editGenome.sh

exomeReport.py -> creates below file

report.txt -> contains summarized report

This script is run by executing the following command while in your week3 directory:
    bash run_scripts.sh
    
    NOTE: Make sure your week3 directory only contains:

    readme.txt

    run_scripts.sh -> executes the following scripts in order
    
    copyExomes.sh -> copies FASTA files of exomes that are sequenced and are between 20mm and 30mm in diameter
                     from data/exomes directory to exomesCohort directory
    
    createCrisprReady.sh -> Outputs headers and sequences of the top three motifs for each exome
                            in exomesCohort to a FASTA file in topmotifs directory
    
    identifyCrisprSite.sh -> Finds sequences that contain 'NGG' with at least 20 basepairs upstream
                             and outputs said sequence and corresponding header to a FASTA file in
                             preCrispr directory

    editGenome.sh -> Inserts Adenine right before the 'NGG' site and outputs header and sequence to 
                     a FASTA file in postCrispr directory

    exomeReport.py -> Generates a report in a text file that summarizes all of the findings 
