#!/bin/env bash

# Download Shotgun metagenomic sequencing data
# SRA Toolkit - https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc
#fastq-dump --gzip --split-files SRR5050591
#fastq-dump --gzip --split-files SRR5050592

# De novo metagenome assembly
# SPAdes - http://cab.spbu.ru/software/spades/
#spades.py -1 SRR5050591_1.fastq.gz -2 SRR5050591_2.fastq.gz -1 SRR5050592_1.fastq.gz -2 SRR5050592_2.fastq.gz -o P78.SPAdes --meta

# Gene annotation and abundance quantification
perl ../../MetaPrism_gene.pl -p 8 P78.gene P78.SPAdes/scaffolds.fasta SRR5050591_1.fastq.gz,SRR5050591_2.fastq.gz SRR5050592_1.fastq.gz,SRR5050592_2.fastq.gz

# Taxon annotation
# Centrifuge - https://ccb.jhu.edu/software/centrifuge/
# ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/data/p_compressed_2018_4_15.tar.gz
perl ../../MetaPrism_taxon_centrifuge.pl -p 8 P78.gene.region.abundance.txt P78.SPAdes/scaffolds.fasta centrifuge/data/p_compressed > P78.gene_taxon.region.abundance.txt

