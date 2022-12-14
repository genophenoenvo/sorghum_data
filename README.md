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

Finally, [matrices are produced] for each line of each vcf file by comparing Genotype values. Partial matches (Cultivar A: `0|1` vs Cultivar B:`1|0`) will correlate at `0.5`.  
