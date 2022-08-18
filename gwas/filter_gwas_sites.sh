#!/bin/bash

for phenotype in max_growth_cm_gdd max_height_cm
do
  awk -F ',' 'BEGIN {OFS="\t"} (NR==1 || $8 < 0.01) {print $0}' $phenotype.FarmCPU.csv > $phenotype.FarmCPU.p001.csv
  cat $phenotype.FarmCPU.p001.csv | cut -d, -f 2,3 | grep -v "CHROM" | sort | uniq | sed 's@"@@g' | tr ',' '\t' > $phenotype.FarmCPU.p001.unique.csv
done
