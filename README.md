# sorghum_data


The `q` command below is http://harelba.github.io/q/

Get the season6 phenotype csv
```bash=
wget https://raw.githubusercontent.com/genophenoenvo/JAGS-logistic-growth/main/data_clean/mac_growth_rate_modeled_season6.csv

```

Get the vcf file

```bash=
wget https://storage.googleapis.com/gpe-sorghum/all_combined_Genotyped_lines.filtered.season4.recode.sorted.fmissing_030.maf_001.contig-filtered.imputed.plink-prune-098.vcf.gz
```

Get the vcf file slimmed down to the right subset of samples
```bash=
q -d, "select distinct genotype from mac_growth_rate_modeled_season6.csv" | sort > season_6_samples.txt

comm -12 <(sort season_4_samples.txt) <(sort season_6_samples.txt) > season_4_and_6_samples.txt

bcftools query -l all_combined_Genotyped_lines.filtered.season4.recode.sorted.fmissing_030.maf_001.contig-filtered.imputed.plink-prune-098.vcf.gz | sort > vcf_samples.txt

comm -12 season_4_and_6_samples.txt vcf_samples.txt > season_4_and_6_vcf_samples.txt

bcftools view --samples-file season_4_and_6_vcf_samples.txt all_combined_Genotyped_lines.filtered.season4.recode.sorted.fmissing_030.maf_001.contig-filtered.imputed.plink-prune-098.vcf.gz > sorghum.filtered.season4.season6.vcf
```

modify the phenotype file, less columns, tab separated
```
q -d, -T -O "select genotype, max_height_cm, max_growth_cm_gdd from mac_growth_rate_modeled_season6.csv" > phenotype/mac_growth_rate_modeled_season6.
tsv
```

[Run GWAS and filter by pvalue](gwas/README.md)

Followed by [filtering the vcf](vcf/README.md) by sites identified by GWAS at differing pvalue cutoffs



File name:

season_phenotype_filter_pvalue_

Example file name for files exported from the VCF filtering process:

season6_maxgrowth_growthrateQTLmaxgrowthGWAS_0001

season6_maxheight_canopyheightGWAS_0001

Each "run" will have one VCF file and a zipped archive with all of the distance matrices for each SNP left after the filtering process is done.

Each "run" will be processed separately against the variation in max growth rate and max height data to identify SNPs with variation that mimic the variation of the phenotype of concern.
