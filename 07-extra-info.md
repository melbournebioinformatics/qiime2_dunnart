---
title: 'Extra Information'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- When and how should you train your own classifier?
- What special considerations exist for NextSeq data and primer trimming?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Describe the procedure to extract region‑specific reference reads and train a naive Bayes classifier from SILVA references.
- Highlight best practices for handling NextSeq 2‑colour chemistry artefacts (e.g. poly‑G tails) and when to perform standalone cutadapt --nextseq‑trim.

::::::::::::::::::::::::::::::::::::::::::::::::



## Extra Information


::: caution

#### STOP

This section contains information on how to train the classifier for analysing your **own** data. This will **NOT** be covered in the workshop.

:::

### Train SILVA v138 classifier for 16S/18S rRNA gene marker sequences.

The newest version of the [SILVA](https://www.arb-silva.de/) database (v138) can be trained to classify marker gene sequences originating from the 16S/18S rRNA gene. Reference files `silva-138-99-seqs.qza` and `silva-138-99-tax.qza` were [downloaded from SILVA](https://www.arb-silva.de/download/archive/) and imported to get the artefact files. You can download both these files from [here](https://www.dropbox.com/s/x8ogeefjknimhkx/classifier_files.zip?dl=0).


Reads for the region of interest are first extracted. **You will need to input your forward and reverse primer sequences**. See QIIME2 documentation for more [information](https://amplicon-docs.qiime2.org/en/stable/references/plugins/feature-classifier.html).


```bash
qiime feature-classifier extract-reads \
--i-sequences silva-138-99-seqs.qza \
--p-f-primer FORWARD_PRIMER_SEQUENCE \
--p-r-primer REVERSE_PRIMER_SEQUENCE \
--o-reads silva_138_marker_gene.qza \
--verbose
```

The classifier is then trained using a naive Bayes algorithm. See QIIME2 documentation for more [information](https://amplicon-docs.qiime2.org/en/stable/references/plugins/feature-classifier.html#q2-action-feature-classifier-fit-classifier-naive-bayes).


```bash
qiime feature-classifier fit-classifier-naive-bayes \
--i-reference-reads silva_138_marker_gene.qza \
--i-reference-taxonomy silva-138-99-tax.qza \
--o-classifier silva_138_marker_gene_classifier.qza \
--verbose
```



::::::::::::::::::::::::::::::::::::: keypoints 

- Training a classifier requires region‑matched reference reads and taxonomy; forward/reverse primers must be provided when extracting reads.
- Classifier training and full classify‑sklearn runs can be computationally demanding — Consider precomputed classifiers or higher memory/CPU resources for large datasets.


::::::::::::::::::::::::::::::::::::::::::::::::

