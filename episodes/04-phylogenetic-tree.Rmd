---
title: 'Build a phylogenetic tree'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- Why is a phylogenetic tree necessary for some diversity metrics?
- What are the main steps from sequences to a rooted tree in QIIME 2?


::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Align representative sequences with MAFFT, mask non‑informative sites, infer a tree with FastTree, and root the tree.
- Produce tree artefacts suitable for phylogenetic diversity and UniFrac analyses.


::::::::::::::::::::::::::::::::::::::::::::::::


## Build a phylogenetic tree

The next step does the following:

1. Perform an alignment on the representative sequences.
2. Mask sites in the alignment that are not phylogenetically informative.
3. Generate a phylogenetic tree.
4. Apply mid-point rooting to the tree.

A phylogenetic tree is necessary for any analyses that incorporates information on the relative relatedness of community members, by incorporating phylogenetic distances between observed organisms in the computation. This would include any beta-diversity analyses and visualisations from a weighted or unweighted Unifrac distance matrix.


```bash
mkdir analysis/tree
```

Use one thread only (which is the default action) so that identical results can be produced if rerun.


```bash
qiime phylogeny align-to-tree-mafft-fasttree \
--i-sequences analysis/dada2out/representative_sequences.qza \
--o-alignment analysis/tree/aligned_16s_representative_seqs.qza \
--o-masked-alignment analysis/tree/masked_aligned_16s_representative_seqs.qza \
--o-tree analysis/tree/16s_unrooted_tree.qza \
--o-rooted-tree analysis/tree/16s_rooted_tree.qza \
--p-n-threads 1 \
--verbose
```



::::::::::::::::::::::::::::::::::::: keypoints 

- Phylogenetic distances are required for phylogenetic alpha and beta metrics (Faith’s PD, UniFrac).
- Use align‑to‑tree‑mafft‑fasttree for a reproducible single‑threaded workflow.
- Keep track of the unrooted and rooted tree artefacts for downstream use.

::::::::::::::::::::::::::::::::::::::::::::::::

