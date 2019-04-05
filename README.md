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
5. From the same website, locate the corresponding GTF file

- example
  - Homo_sapiens.GRCh38.94.gtf.gz

6. Rightclick over file link and copy URL address

7. In the same directory, download GTF file using wget
```
wget {URL address}
```
  example
```
wget ftp://ftp.ensembl.org/pub/release-94/gtf/homo_sapiens/Homo_sapiens.GRCh38.94.gtf.gz
```

8. Unzip FASTA and GTF files
```
gunzip Homo_sapiens.GRCh38.dna.toplevel.fa.gz
gunzip Homo_sapiens.GRCh38.94.gtf.gz
```

## Building a Bowtie index (for Tophat2 alignment)
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
You can submit the job to the cluster using an sbatch shell script. See bowtie2_index.sh

Make sure to cutomize (i.e. output file name ".stdout", email, jobname, directory, file name of FASTA)

This script will submit the job into the cluster. All STDOUT will be redirected to a file called “my.stdout” as well as an email sent to the user when the status of the job changes.

```
sbatch bowtie2_index.sh
```
## Building a Hisat2 index (for Hisat2 alignment)
If using bowtie2, use bowtie2-build to generate the index:

1. First load bowtie2
```
module load hisat2
```

2. Run bowtie2-build. Bowtie2-build takes the name of the FASTA file (first argument) and creates index files using the name of the FASTA file as the basename (second argument)
```
hisat2-build {name_of_FASTA_file} {name_of_FASTA_file}
```
Example
```
hisat2-build Homo_sapiens.GRCh38.dna.toplevel.fa.gz Homo_sapiens.GRCh38.dna.toplevel.fa.gz
```

Building a hisat2 index can take 1-2 hours
You can submit the job to the cluster using an sbatch shell script. See hisat2_index.sh

Make sure to cutomize (i.e. output file name ".stdout", email, jobname, directory, file name of FASTA)

This script will submit the job into the cluster. All STDOUT will be redirected to a file called “my.stdout” as well as an email sent to the user when the status of the job changes.

```
sbatch hisat2_index.sh
```

## Creating host/virus reference
1. Download the viral genome in FASTA format using wget. Can use below link as a source
https://www.viprbrc.org/brc/home.spg?decorator=vipr

2. Concatenate host and viral FASTA files. 
```
cat {host_FASTA} {virus_FASTA} > {give_new_name}
```
2. Change chromosome identifier in new FASTA file. Because viral genomes are small, they can be annotated as if they were an additional chromosome in the host genome. The header information of the viral FASTA file needs to be amended to look like the host.
- enter a highmem subnode
```
srun -p highmem --mem=100g --time=24:00:00 --pty bash -l
```
- open new FASTA file using nano and scroll to the end to find the viral genome ("control" "w" "v" and "control" "y")

- change chromosome identifier to follow format of host genome, but still be unique from the rest of the host genome
- save file

3. Modify host GTF file to include information about viral genome. 
- Most databases for viral genomes will provide information about each viral gene but won't format that information as a GTF. 
- In the host GTF file add information for each viral gene at the end of the file, following the GTF format as the host. 
- Annotate each gene as a gene and exon and use the same chromosome identifier as previously defined in the concatenated FASTA file. 

