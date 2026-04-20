---
title: 'Exporting data for further analysis in R'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 


- Which files are typically exported for downstream R analysis (phyloseq, DESeq2, etc.)?
- What format conversions are required to obtain usable TSVs and tree files?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Export the unrooted tree (.nwk), feature table (BIOM), taxonomy and representative sequences to a structured export folder.
- Convert BIOM to TSV and clean headers so R packages can import tables reliably.
- Ensure taxonomic rows and ASV columns are consistently ordered for downstream merging.


::::::::::::::::::::::::::::::::::::::::::::::::


## Section 5: Exporting data for further analysis in R

You need to export your ASV table, taxonomy table, and tree file for analyses in R. Many file formats can be accepted.

Export unrooted tree as `.nwk` format as required for the R package `phyloseq`.


```bash
qiime tools export \
  --input-path analysis/tree/16s_unrooted_tree.qza \
  --output-path analysis/export
```

Create a BIOM table with taxonomy annotations. A FeatureTable[Frequency] artefact will be exported as a BIOM v2.1.0 formatted file.


```bash
qiime tools export \
  --input-path analysis/taxonomy/16s_table_filtered.qza \
  --output-path analysis/export
```

Then export BIOM to TSV

```bash
biom convert \
-i analysis/export/feature-table.biom \
-o analysis/export/feature-table.tsv \
--to-tsv
```

Export Taxonomy as TSV


```bash
qiime tools export \
--input-path analysis/taxonomy/classification.qza \
--output-path analysis/export
```

Delete the header lines of the .tsv files

``` bash
sed '1d' analysis/export/taxonomy.tsv > analysis/export/taxonomy_noHeader.tsv
sed '1d' analysis/export/feature-table.tsv > analysis/export/feature-table_noHeader.tsv
```

Some packages require your data to be in a consistent order, i.e. the order of your ASVs in the taxonomy table rows to be the same order of ASVs in the columns of your ASV table. It's recommended to clean up your taxonomy file. You can have blank spots where the level of classification was not completely resolved.



::::::::::::::::::::::::::::::::::::: keypoints 

- Exported artefacts include: tree (Newick), feature‑table.biom, taxonomy.tsv and representative sequences if required.
- Use biom convert to produce TSV tables and sed (or equivalent) to remove extra header lines.
- Confirm consistent ASV order between taxonomy and table files before importing into phyloseq or other R packages.

::::::::::::::::::::::::::::::::::::::::::::::::

