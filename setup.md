---
title: Setup
---


## Author Information
Developed by: Dr. Ashley Dungan and Dr. Gayle Philip 
School of Biosciences, University of Melbourne; Melbourne Bioinformatics

Created/Reviewed: April 2026


## Overview


This page outlines the steps, beginning with raw data from the sequencing facility, that were followed to produce the 16S rRNA metabarocoding files used in R for data analysis. All intermediate .qza and .qzv files are provided. This data processing was completed in QIIME2 v2026.1 by Ashley Dungan in March 2026. 

Anticipated workshop duration when delivered to a group of participants is **4 hours**.  

For queries relating to this workshop, contact Melbourne Bioinformatics (bioinformatics-training@unimelb.edu.au).


## Learning Objectives

At the end of this introductory workshop, you will:

* Take raw data from a sequencing facility and end with publication quality graphics and statistics
* Answer the question *What is the influence of captivity on gut microbiota of the fat-tailed dunnart?*


## Slides and workshop instructions
Click <a href="./files/QIIME2_workshop_MelbBioinformatics_April2026.pdf" type="application/pdf" target="_blank">here</a> for slides presented during this workshop.



## Data

Data from the Walter and Eliza Hall Institute (WEHI) came as paired-end, demultiplexed (.fastq) files with primers and overhang sequences still attached. 
Samples were sequenced on a single NextSeq run.

### Downloading data

* No additional data needs to be downloaded for this workshop - it is all located on the Nectar Instance. FASTQs are located in the directory `raw_data` and a metadata (`dunnart_metadata.tsv`) file has also been provided.

* If you wish to analyse the data independently at a later stage, it can be downloaded from [here](https://zenodo.org/records/10158305). This link contains both the FASTQs and associated metadata file.

* If you are running this tutorial independently, you can also access the classifier that has been trained specifically for this data from [here](https://www.dropbox.com/scl/fi/s42p5fif7szzm38swcu0m/silva_138_16s_515-806_classifier.qza?rlkey=ss983qau9rwgztis2gfulhjcz&dl=0).


## Prequisites

This workshop is designed for participants with command-line knowledge. You will need to be able to `ssh` into a remote machine, navigate the directory structure and `scp` files from a remote computer to your local computer.



## Software Setup

::::::::::::::::::::::::::::::::::::::: discussion

### Details

For an in-person workshop, you will need access to Nectar instances.
Login information will be provided to you prior to the workshop start date.
You can find more information about Nectar instances [here](https://mbite.mdhs.unimelb.edu.au/nectar-instances/logging-on-to-a-nectar-instance.html).

You will need to use a Google Chrome or Mozilla Firefox web browser to view files in QIIME2 View.

:::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: solution

### Windows

Use PuTTY

:::::::::::::::::::::::::

:::::::::::::::: solution

### MacOS

Use Terminal.app

:::::::::::::::::::::::::


:::::::::::::::: solution

### Linux

Use Terminal

:::::::::::::::::::::::::


## Initial Set up on Nectar

### Byobu-screen

To ensure that commands continue to run should you get disconnected from your Nectar Instance, we'll [run a byobu-screen session](https://www.melbournebioinformatics.org.au/tutorials/tutorials/workshop_delivery_mode_info/workshops_nectar/#byobu-screen).


#### Starting a byobu-screen session
On Nectar, to start a `byobu-screen` session called `workshop`, type  

```bash
byobu-screen -S workshop
```

#### Reconnecting to a byobu-screen session
If you get disconnected from your Nectar Instance, follow the instructions [here](https://www.melbournebioinformatics.org.au/tutorials/tutorials/workshop_delivery_mode_info/workshops_nectar/#reconnecting-to-a-byobu-screen-session) to resume your session.


### Symbolic links to workshop data
Data for this workshop is stored in a central location (`/mnt/shared_data/`) on the Nectar file system that we will be using. We will use symbolic links (`ln -s`) to point to it. Symbolic links (or symlinks) are just "virtual" files or folders (they only take up a very little space) that point to a physical file or folder located elsewhere in the file system. Sequencing data can be large, and rather than unnecessarily having multiple copies of the data which can quickly take up a lot of space, we will simply point to the files needed in the `shared_data` folder.


```bash
cd
mkdir raw_data; cp -rs /mnt/shared_data/raw_data/* raw_data 
ln -s /mnt/shared_data/dunnart_metadata.tsv dunnart_metadata.tsv
ln -s /mnt/shared_data/silva_138.2_16s_v4_classifier.qza silva_138.2_16s_v4_classifier.qza
```



