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

Using the ANN section of the INFO column...

```
##INFO=<ID=ANN,Number=.,Type=String,Description="Functional annotations: 'Allele | Annotation | Annotation_Impact | Gene_Name | Gene_ID | Feature_Type | Feature_ID | Transcript_BioType | Rank | HGVS.c | HGVS.p | cDNA.pos / cDNA.length | CDS.pos / CDS.length | AA.pos / AA.length | Distance | ERRORS / WARNINGS / INFO' ">
```

Create a file and append to it from a bcftools query:

```
echo "ID\tAllele\tAnnotation\tAnnotation_Impact\tGene_Name\tGene_ID\tFeature_Type\tFeature_ID\tTranscript_BioType" > variant_annotaions.tsv
bcftools query -f "%ID|%ANN \n" sorghum.filtered.season4.season6.annotated.vcf.gz | cut -d'|' -f 1,2,3,4,5,6,7,8,9 | tr '|' '\t' >> variant_annotaions.tsv
```
