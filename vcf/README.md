Filter the vcf based on this regions file

First, re-compress the vcf file, then index it
```bash=
bgzip sorghum.filtered.season4.season6.vcf
tabix sorghum.filtered.season4.season6.vcf.gz
```

Run the filter against all of the phenotype and pvalue combinations, plus add qtl filtered versions
```bash=
./filter.sh 
```

