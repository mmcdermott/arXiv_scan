#!/bin/bash

CHUNK_FILE="$1"
BASE_DIR="$2"
OUT_DIR="$3"

while IFS= read -r pdf_path; do
    # Generate output text file path
    relative_path="${pdf_path#$BASE_DIR/}"
    txt_path="$OUT_DIR/${relative_path%.pdf}.txt"

    echo "Writing $pdf_path to $txt_path"

    # Check if the output file already exists
    if [ ! -f "$txt_path" ]; then
        # Create directory if it doesn't exist
        mkdir -p "$(dirname "$txt_path")"

        # Call your pdf_to_text script with input and output paths
        /home/mbm47/.conda/envs/arxiv_scan/bin/python ./src/arxiv_scan/scan_from_pdf.py --in_fp="$pdf_path" --out_fp="$txt_path"
    fi
done < "$CHUNK_FILE"
