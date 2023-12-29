#!/bin/bash

BASE_DIR="$1"
OUT_DIR="$2"
TMP_FILE_LIST="pdf_files_list.txt"
N=$3  # Number of chunks

# Find all PDF files and save their paths to a file
find "$BASE_DIR" -name "*.pdf" > "$TMP_FILE_LIST"

# Count total number of files
TOTAL_FILES=$(wc -l < "$TMP_FILE_LIST")

# Calculate number of files per chunk (ceil division)
FILES_PER_CHUNK=$(( (TOTAL_FILES + N - 1) / N ))

# Create chunks with numeric suffixes
for i in $(seq 1 $N); do
    start_line=$(( (i - 1) * FILES_PER_CHUNK + 1 ))
    end_line=$(( i * FILES_PER_CHUNK ))

    # Use 'sed' to extract a range of lines for each chunk
    sed -n "${start_line},${end_line}p" "$TMP_FILE_LIST" > "chunk_$i"
done

# Submit array job
sbatch --array=1-$N "convert_pdf_to_text.sbatch.sh" "$BASE_DIR" "$OUT_DIR"
