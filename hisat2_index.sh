#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --output=my.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="just_a_test"
#SBATCH -p intel # This is the default partition, you can use any of the following; intel, batch, highmem, gpu


# Print current date
date

# Load samtools
module load hisat2

# Change directory to where you submitted the job from, so that relative paths resolve properly
# Make sure to use the absolute path
SLURM_SUBMIT_DIR: /bigdata/messaoudilab/arivera/ReferenceGenome/Homo_sapiens
cd $SLURM_SUBMIT_DIR

# Concatenate BAMs
hisat2-build Homo_sapiens.GRCh38.dna.toplevel.fa.gz Homo_sapiens.GRCh38.dna.toplevel.fa.gz

# Print name of node
hostname
