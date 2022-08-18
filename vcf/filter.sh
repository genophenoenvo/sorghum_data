#!/bin/bash

for phenotype in max_growth_cm_gdd max_height_cm
do
  for pvalue in p0001 p0005 p001
  do
    echo "======= ${phenotype} $pvalue ======="
    bcftools view --regions-file ../gwas/$phenotype.FarmCPU.$pvalue.unique.csv sorghum.filtered.season4.season6.vcf.gz -Oz -o sorghum.filtered.season4.season6.${phenotype}_$pvalue.vcf.gz
    tabix sorghum.filtered.season4.season6.${phenotype}_$pvalue.vcf.gz
    bcftools view --regions-file ../qtl/${phenotype}_qtl_regions.txt sorghum.filtered.season4.season6.${phenotype}_$pvalue.vcf.gz -Oz -o sorghum.filtered.season4.season6.${phenotype}_${pvalue}_qtl.vcf.gz
  done
done
