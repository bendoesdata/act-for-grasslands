#!/bin/bash

# Check if ImageMagick's mogrify command is available
if ! command -v mogrify &> /dev/null; then
    echo "Error: ImageMagick's mogrify command is not available."
    echo "Please install ImageMagick to use this script."
    exit 1
fi

# Directory containing images
DIR="./"

# Resize images
for img in "$DIR"*.jpg "$DIR"*.jpeg "$DIR"*.png; do
    # Check if file exists (in case no files match the pattern)
    if [[ -f "$img" ]]; then
        echo "Resizing $img..."
        mogrify -resize '2400x>' "$img"
    fi
done

echo "Done resizing images."
