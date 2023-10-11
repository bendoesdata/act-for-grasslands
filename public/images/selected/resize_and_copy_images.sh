#!/bin/bash

# Check if ImageMagick's convert command is available
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick's convert command is not available."
    echo "Please install ImageMagick to use this script."
    exit 1
fi

# Directory containing images
DIR="./"

# Process images
for img in "$DIR"*.jpg "$DIR"*.jpeg "$DIR"*.png; do
    # Check if file exists (in case no files match the pattern)
    if [[ -f "$img" ]]; then
        # Extract filename without extension and the extension
        filename=$(basename -- "$img")
        extension="${filename##*.}"
        filename_noext="${filename%.*}"

        # Create new filename with "-small" appended
        new_filename="small-${filename_noext}.${extension}"

        echo "Processing $img -> $new_filename..."
        convert "$img" -resize '600x' "$DIR$new_filename"
    fi
done

echo "Done processing images."
