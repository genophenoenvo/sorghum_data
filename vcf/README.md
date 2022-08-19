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

Annotate the vcf file with snpEff

```bash=
java -Xmx8g -jar ../../snpEff/snpEff.jar Sorghum_bicolor ./sorghum.filtered.season4.season6.vcf.gz | gzip > sorghum.filtered.season4.season6.annotated.vcf.gz
```
