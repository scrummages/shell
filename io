#!/bin/sh

local preserve_extension=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p)
            preserve_extension=true
            shift
            ;;
        *)
            break
            ;;
    esac
done

input_file="$1"
output_file="${preserve_extension:+${input_file%.*}.jpg}"

if "$preserve_extension"; then
    ffmpeg -i "$input_file" "$output_file"
else
    ffmpeg -i "$input_file" "${output_file%%.*}".jpg
fi

input_size=$(du -k "$input_file" | cut -f1)
output_size=$(du -k "$output_file" | cut -f1)

difference=$((input_size - output_size))
percentage_change=$(awk "BEGIN {print ($difference / $input_size) * 100}")

echo -e "Input size: ${input_size}KB"
echo -e "Output size: ${output_size}KB"
echo -e "Size difference (Input - Output): ${difference}KB"
echo -e "Percentage change: ${percentage_change}%"

if [ "$difference" -lt 0 ]; then
    echo -e "\e[31mWarning: Output size is larger than input size!\e[0m"
elif [ "$difference" -eq 0 ]; then
    echo -e "\e[33mNote: No size difference between input and output.\e[0m"
else
    echo -e "\e[32mSuccess: Output size is smaller than input size by ${difference}KB (${percentage_change}% smaller).\e[0m"
fi
