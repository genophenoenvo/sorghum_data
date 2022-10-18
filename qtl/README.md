After download from http://aussorgm.org.au and converting from excel to tsv, I kept the columns I needed
and renamed to match our phenotype trait names.

```bash
cut -f 5 plant_height_qtl.tsv | grep "^[0-9]" | sed 's@:@\t@' | sed 's@-@\t@' | sed 's@^\([0-9]\)\t@0\1\t@' > max_height_cm_qtl_regions.txt
cut -f 5 growth_rate_qtl.tsv | grep "^[0-9]" | sed 's@:@\t@' | sed 's@-@\t@' | sed 's@^\([0-9]\)\t@0\1\t@' > max_growth_cm_gdd_qtl_regions.txt
```


