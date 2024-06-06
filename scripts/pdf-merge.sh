#!/bin/bash

# Output filename
output_file="merged.pdf"

# Check if qpdf is installed
if ! command -v qpdf &> /dev/null; then
  echo "Error: qpdf is not installed. Please install qpdf and try again."
  exit 1
fi

# Get all PDF files in the current directory
pdf_files=( *.pdf )

# Check if there are any PDF files
if [[ ${#pdf_files[@]} -eq 0 ]]; then
  echo "Error: No PDF files found in the current directory."
  exit 1
fi

# Initialize the output with the first PDF
qpdf "${pdf_files[0]}" "$output_file"

# Loop through remaining PDF files and merge them
for (( i=1; i<${#pdf_files[@]}; i++ )); do
  qpdf "$output_file" "${pdf_files[$i]}"  # No --outputFile flag needed
done

echo "Successfully merged all PDF files into $output_file"
