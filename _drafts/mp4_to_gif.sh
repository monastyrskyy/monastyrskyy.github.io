#!/bin/bash

# Directory containing MP4 files (you can change this if needed)
input_dir="."

# Create the frames directory if it doesn't exist
mkdir -p frames

# Loop through each MP4 file in the input directory
for mp4_file in "$input_dir"/*.mp4; do
  # Get the base filename without the extension
  filename=$(basename "$mp4_file" .mp4)

  # Create a separate frames directory for this mp4 file
  mkdir -p frames/"$filename"

  # Extract frames from the MP4 file at 24fps and save them to the specific frames folder
  ffmpeg -i "$mp4_file" -vf "fps=24,scale=640:-1:flags=lanczos" frames/"$filename"/frame%03d.png

  # Generate a color palette for better GIF quality
  ffmpeg -i frames/"$filename"/frame%03d.png -vf "palettegen" frames/"$filename"/palette.png

  # Create the GIF using the frames and the color palette, save it in the original directory
  ffmpeg -i frames/"$filename"/frame%03d.png -i frames/"$filename"/palette.png -lavfi "fps=24,scale=640:-1:flags=lanczos [x]; [x][1:v] paletteuse" "$filename.gif"

  # Optional: clean up the frames and palette for this MP4 file
  # rm -r frames/"$filename"
done

