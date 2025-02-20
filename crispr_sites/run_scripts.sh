#!/bin/bash

echo "Hello. See report.txt for the summarized report,"
echo "and see readme.txt for details on script inputs, outputs, and execution."
echo ""

#Executes these files in order
bash copyExomes.sh
bash createCrisprReady.sh
bash identifyCrisprSite.sh
bash editGenome.sh
python3 exomeReport.py
