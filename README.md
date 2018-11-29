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

1. Locate DNA FASTA file of species. Either primary assembly or toplevel version of genome can be used.

- example:
  - Homo_sapiens.GrCh38.dna.primary_assembly.fa.gz
  - Homo_sapiens.GRCh38.dna.toplevel.fa.gz

2. Rightclick over file link and copy URL address

3. In the UCR HPCC cluster, create directory where you want to store reference genome
```
mkdir "Homo_sapiens_refgenome"
```
4. In the new directory, download FASTA file using wget
```
wget {URL address}
```
example
```
wget ftp://ftp.ensembl.org/pub/release-94/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.toplevel.fa.gz
```

4.From the same website, locate the corresponding GTF file

- example
  - Homo_sapiens.GRCh38.94.gtf.gz

5. Rightclick over file link and copy URL address

6. In the same directory, download GTF file using wget
```
wget {URL address}
```
example
```
wget ftp://ftp.ensembl.org/pub/release-94/gtf/homo_sapiens/Homo_sapiens.GRCh38.94.gtf.gz
```

7. Unzip FASTA and GTF files
```
gunzip Homo_sapiens.GRCh38.dna.toplevel.fa.gz
gunzip Homo_sapiens.GRCh38.94.gtf.gz
```

## Building an index
Alignment requires an index to be generated for each reference genome
Each type of aligner requires it's own index

If using bowtie2, use bowtie2-build to generate the index:

1. First load bowtie2
```
module load bowtie2
```

2. Run bowtie2-build. Bowtie2-build takes the name of the FASTA file (first argument) and creates index files using the name of the FASTA file as the basename (second argument)
```
bowtie2-build {name_of_FASTA_file} {name_of_FASTA_file}
```
Example
```
bowtie2-build Homo_sapiens.GRCh38.dna.toplevel.fa.gz Homo_sapiens.GRCh38.dna.toplevel.fa.gz
```

Building a bowtie index can take 1-2 hours
You can submit the job to the cluster using an sbatch shell script. See example
```
sbatch bowtie2_index.sh
```
## Creating host/virus reference
1. Concatenate 
