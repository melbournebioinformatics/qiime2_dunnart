---
title: 'Taxonomic Analysis'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 


- How is taxonomy assigned to the representative sequences?
- Why must the classifier match the amplified region?
- What filtering steps are commonly applied to taxonomic results?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Apply a pre‑trained classifier appropriate for the V4 16S region to assign taxonomy to ASVs.
- Generate a taxonomic summary visualization and interpret broad community composition.
- Filter out non‑target classifications (mitochondria, chloroplast) from the feature table.

::::::::::::::::::::::::::::::::::::::::::::::::


## Section 2: Taxonomic Analysis

### Assign taxonomy
Here we will classify each identical read or *Amplicon Sequence Variant (ASV)* to the highest resolution based on a database. Common databases for bacteria datasets are [SILVA](https://www.arb-silva.de/), [Ribosomal Database Project](http://rdp.cme.msu.edu/), or [Genome Taxonomy Database](https://gtdb.ecogenomic.org/). See [Porter and Hajibabaei, 2020](https://www.frontiersin.org/articles/10.3389/fevo.2020.00248/full) for a review of different classifiers for metabarcoding research. The classifier chosen is dependent upon:

1. Previously published data in a field
2. The target region of interest
3. The number of reference sequences for your organism in the database and how recently that database was updated.


A classifier has already been trained for you for the V4 region of the bacterial 16S rRNA gene using the SILVA database. The next step will take a while to run. *The output directory cannot previously exist*.


`n_jobs = 1`  This runs the script using all available cores

::: callout

[The classifier](https://www.dropbox.com/scl/fi/s42p5fif7szzm38swcu0m/silva_138_16s_515-806_classifier.qza?rlkey=ss983qau9rwgztis2gfulhjcz&dl=0) used here is only appropriate for the specific 16S rRNA region that *this* data represents. You will need to train your own classifier for your own data. For more information about training your own classifier, see [Extra Information](./07-extra-info.html#train-silva-v138-classifier-for-16s18s-rrna-gene-marker-sequences-).


:::

::: caution

#### STOP - workshop participants only

Due to time limitations in a workshop setting, please do NOT run the `qiime feature-classifier classify-sklearn` command below. You will need to access a pre-computed `classification.qza` file that this command generates by running the following: `cd; mkdir analysis/taxonomy; cp /mnt/shared_data/pre_computed/classification.qza analysis/taxonomy`. If you have accidentally run the command below, `ctrl-c` will terminate it.

:::


```bash
qiime feature-classifier classify-sklearn \
--i-classifier silva_138.2_16s_v4_classifier.qza \
--i-reads analysis/dada2out/representative_sequences.qza \
--p-n-jobs 1 \
--output-dir analysis/taxonomy \
--verbose
```


::: caution

This step often runs out of memory on full datasets. Some options are to change the number of cores you are using (adjust `--p-n-jobs`) or add `--p-reads-per-batch 10000` and try again. The QIIME 2 forum has many threads regarding this issue so always check there was well.

:::


### Generate a viewable summary file of the taxonomic assignments.


```bash
qiime metadata tabulate \
--m-input-file analysis/taxonomy/classification.qza \
--o-visualization analysis/visualisations/taxonomy.qzv \
--verbose
```


::::::::::::::::::::::::::::::::::::: challenge

#### Visualisation: Taxonomy

Copy `analysis/visualisations/taxonomy.qzv` to your local computer and view in QIIME 2 View (q2view).

:::::::::::::::: solution

[Click to view the **`taxonomy.qzv`** file in QIIME 2 View](https://view.qiime2.org/visualization/?type=html&src=https%3A%2F%2Fdl.dropboxusercontent.com%2Fscl%2Ffi%2Fpl5fz8bfv3iraqe7w3ryt%2Ftaxonomy.qzv%3Frlkey%3Dbnury3ua0w002sozo0eudklv7%26dl%3D1).

:::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::    


### Filtering

Filter out reads classified as mitochondria and chloroplast. Unassigned ASVs are retained. Generate a viewable summary file of the new table to see the effect of filtering.

According to QIIME developer Nicholas Bokulich, low abundance filtering (i.e. removing ASVs containing very few sequences) is not necessary under the ASV model.


```bash
qiime taxa filter-table \
--i-table analysis/dada2out/table.qza \
--i-taxonomy analysis/taxonomy/classification.qza  \
--p-exclude Mitochondria,Chloroplast \
--o-filtered-table analysis/taxonomy/16s_table_filtered.qza \
--verbose
```

```bash
qiime feature-table summarize \
--i-table analysis/taxonomy/16s_table_filtered.qza \
--m-sample-metadata-file dunnart_metadata.tsv \
--o-visualization analysis/visualisations/summary_table_filtered \
--verbose
```



::::::::::::::::::::::::::::::::::::: challenge

#### Visualisation: Feature/ASV summary-Filtered

Copy `analysis/visualisations/summary_table_filtered/summary.qzv` to your local computer and view in QIIME 2 View (q2view).

:::::::::::::::: solution

[Click to view the **`summary.qzv`** file in QIIME 2 View](https://view.qiime2.org/visualization/?src=https%3A%2F%2Fdl.dropboxusercontent.com%2Fscl%2Ffi%2F9c1m746lxuplmwb79gldo%2F16s_table_filtered.qzv%3Frlkey%3D9iz32202xm36rfac3r7i50wtx%26dl%3D1&type=html).


:::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::    




::::::::::::::::::::::::::::::::::::: keypoints 

- Classifier must be trained for the same primer/region used in the dataset; mismatched classifiers give poor results.
- The `classify‑sklearn` step can be memory intensive — precomputed classifications are provided for the workshop.
- Retain unassigned ASVs (they may still be biologically meaningful), but exclude obvious host/plant contaminants.
- Low‑abundance filtering is generally unnecessary with the ASV paradigm unless specific reasons exist.

::::::::::::::::::::::::::::::::::::::::::::::::

