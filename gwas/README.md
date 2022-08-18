Run the GWAS analysis interactively in R

```R=
library(rMVP)
library(readr)


##input file preparation
MVP.Data(fileVCF="../vcf/sorghum.filtered.season4.season6.vcf",
         filePhe="../phenotype/mac_growth_rate_modeled_season6.tsv",
         fileKin=TRUE,
         filePC=TRUE,
         out="sorghum.filtered.season4.season6"
)

##attach input file
genotype <- attach.big.matrix("sorghum.filtered.season4.season6.geno.desc")
phenotype <- read.table("sorghum.filtered.season4.season6.phe",head=TRUE)
map <- read.table("sorghum.filtered.season4.season6.geno.map" , head = TRUE)
Covariates <- attach.big.matrix("sorghum.filtered.season4.season6.pc.desc")
kinship <- attach.big.matrix("sorghum.filtered.season4.season6.kin.desc")

##GWAS analysis

for(i in 2:ncol(phenotype)){
  imMVP <- MVP(
    phe=phenotype[, c(1, i)],
    geno=genotype,
    map=map,
    K=kinship,
    nPC.MLM = 1,
    nPC.FarmCPU = 1,
    threshold=0.05,
    method=c("MLM", "FarmCPU")
  )
  gc()
}

```

Then filter the csv output for each phenotype. I manually ran this multiple times at different pvalues rather than parameterizing the script.

```bash=
for phenotype in max_growth_cm_gdd max_height_cm
do
  awk -F ',' 'BEGIN {OFS="\t"} (NR==1 || $8 < 0.01) {print $0}' $phenotype.FarmCPU.csv > $phenotype.FarmCPU.p001.csv
  cat $phenotype.FarmCPU.p001.csv | cut -d, -f 2,3 | grep -v "CHROM" | sort | uniq | sed 's@"@@g' | tr ',' '\t' > $phenotype.FarmCPU.p001.unique.csv
done
```

