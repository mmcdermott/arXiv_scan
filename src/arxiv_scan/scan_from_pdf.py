from pathlib import Path
from pypdf import PdfReader
from tqdm.auto import tqdm
import logging
import json
import argparse

logger = logging.getLogger(__name__)

def convert_to_text(in_fp: Path, out_fp: Path):
    """
    Converts a PDF file to text and stores it in out_fp.
    """

    reader = PdfReader(in_fp)
    for i in range(len(reader.pages)):
        with open(out_fp, "a") as f:
            try:
                f.write(reader.pages[i].extract_text() + "\n")
            except Exception as e:
                logger.warning(f"Failed to extract text from page {i} of {in_fp}: {e}.")
                continue

#def main():
#    """
#    Converts all PDF files in the current directory to text files.
#    """
#
#    parser = argparse.ArgumentParser(
#        description="Converts all PDF files in the specified directory to text files."
#    )
#    parser.add_argument("--in_directory", type=str, help="The directory to scan for PDF files.")
#    parser.add_argument("--out_directory", type=str, help="The directory to store the text files.")
#
#    args = parser.parse_args()
#
#    pdf_fps = list(Path(args.in_directory).glob("*.pdf"))
#    for in_fp in tqdm(pdf_fps):
#        out_fp = Path(args.out_directory) / in_fp.name
#        out_fp.parent.mkdir(exist_ok=True, parents=True)
#        convert_to_text(in_fp, out_fp.with_suffix(".txt"))
#
#if __name__ == "__main__":
#    main()

def main():
    """
    Converts the specified PDF file to text.
    """

    parser = argparse.ArgumentParser(
        description="Converts all PDF files in the specified directory to text files."
    )
    parser.add_argument("--in_fp", type=str, help="The PDF file to convert.")
    parser.add_argument("--out_fp", type=str, help="The TXT file to write.")

    args = parser.parse_args()
    if Path(args.out_fp).exists():
        logger.warning(f"File {args.out_fp} already exists. Skipping.")
        return
    convert_to_text(args.in_fp, args.out_fp)

if __name__ == "__main__":
    main()
