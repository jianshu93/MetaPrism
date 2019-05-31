#!/bin/env bash

# Download Shotgun metagenomic sequencing data
# SRA Toolkit - https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc
fastq-dump --gzip --split-files SRR5930493

# De novo metagenome assembly
# SPAdes - http://cab.spbu.ru/software/spades/
spades.py -1 SRR5930493_1.fastq.gz -2 SRR5930493_2.fastq.gz -o P22.SPAdes --meta

# Gene annotation and abundance quantification
perl ../../MetaPrism_gene.pl -p 8 P22.gene P22.SPAdes/scaffolds.fasta SRR5930493_1.fastq.gz,SRR5930493_2.fastq.gz

# Taxon annotation
# Centrifuge - https://ccb.jhu.edu/software/centrifuge/
# ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/data/p_compressed_2018_4_15.tar.gz
perl ../../MetaPrism_taxon_centrifuge.pl -p 8 P22.gene.region.abundance.txt P22.SPAdes/scaffolds.fasta centrifuge/data/p_compressed > P22.gene_taxon.region.abundance.txt

