# Reference_Genomes

## Downloading FASTA and GTF files
### FASTA file
FASTA format is a text-based format for representing either nucleotide sequences or peptide sequences, in which base pairs or amino acids are represented using single-letter codes. A sequence in FASTA format begins with a single-line description, followed by lines of sequence data.

### GTF file
The Gene transfer format (GTF) is a file format used to hold information about gene structure. It is a tab-delimited text format based on the general feature format (GFF), but contains some additional conventions specific to gene information.
https://uswest.ensembl.org/info/website/upload/gff.html

### Resources
FASTA and GTF files can be downloaded from ENSEMBL
https://uswest.ensembl.org/info/data/ftp/index.html

Locate DNA FASTA file of species. Either primary assembly or toplevel version of genome can be used.

- example:
  - Homo_sapiens.GrCh38.dna.primary_assembly.fa.gz
  - Homo_sapiens.GRCh38.dna.toplevel.fa.gz

- Rightclick over file link and copy URL address

In the UCR HPCC cluster, create directory where you want to store reference genome
```
mkdir "Homo_sapiens_refgenome"
```
In the new directory, download FASTA file using wget
```
wget {URL address}
```
example
```
wget ftp://ftp.ensembl.org/pub/release-94/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.toplevel.fa.gz
```

From the same website, locate the corresponding GTF file

- example
  - Homo_sapiens.GRCh38.94.gtf.gz

- Rightclick over file link and copy URL address

In the same directory, download GTF file using wget
```
wget {URL address}
```
example
```
wget ftp://ftp.ensembl.org/pub/release-94/gtf/homo_sapiens/Homo_sapiens.GRCh38.94.gtf.gz
```

## Building an index
Building an index

## Creating host/virus reference
