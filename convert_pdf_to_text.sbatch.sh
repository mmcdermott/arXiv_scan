#!/bin/bash
#SBATCH -c 2                               # 1 core
#SBATCH -t 0-04:45                         # Runtime of 105 minutes, in D-HH:MM format
#SBATCH --mem=700                          # Memory of 400 MB
#SBATCH -p short                           # Run in short partition
#SBATCH -o hostname_%j_%a.out              # File to which STDOUT + STDERR will be written, including job ID in filename
#SBATCH -e hostname_%j_%a.err              # File to which STDOUT + STDERR will be written, including job ID in filename

# SLURM array job index is used to pick the chunk
CHUNK_FILE="chunk_$SLURM_ARRAY_TASK_ID"

module load miniconda3/4.10.3

# Activate the conda env
source activate arxiv_scan

cd /n/data1/hms/dbmi/zaklab/mmd/arXiv_scan

# Call the chunk processing script with the chunk file
./process_chunk.sh "$CHUNK_FILE" $@
