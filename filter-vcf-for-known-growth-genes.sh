#!/bin/sh

bcftools view --regions-file growth_gene_regions.txt ./vcf/sorghum.filtered.season4.season6.vcf.gz -Oz -o ./vcf/sorghum.filtered.season4.season6.growth_gene_regions.vcf.gz
