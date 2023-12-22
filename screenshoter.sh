#!/bin/bash

d=$(date -R)
if [ -d "$HOME/Recordings/screenshot-recordings$d" ]; then
    echo "The folder exists."
else
    mkdir "$HOME/Recordings/screenshot-recordings$d"
fi

counter=1
folder="$HOME/Recordings/screenshot-recordings$d"

while true; do
    filename="$folder/screenshot_$counter.png"

    # Capture screenshot with scrot
    scrot -pzq 1 -Z 9 "$filename"

    # Convert the screenshot to WebP
    cwebp -q 30 "$filename" -o "$folder/screenshot_$counter.webp"

    # Delete the original file
    rm "$filename"

    # Increment the counter
    ((counter++))

    sleep 5
done
