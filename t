#!/bin/sh

function t() {
	if [ $# -lt 1 ]; then
	  random_chars=$(tr -dc "a-z" </dev/urandom | head -c 10)
	  temp_dir="/tmp/t/$random_chars"
	  echo "Created $temp_dir without a name. Remember, to create with a name use: t <directory_name>"
	  mkdir -p "$temp_dir" && cd "$temp_dir"
	  return 1
	elif [ "$1" == "c" ]; then
	  rm -rf /tmp/t/*
	  echo "Deleted all files inside /tmp/t"
	else
	  random_chars=$(tr -dc "a-z" </dev/urandom | head -c 10)
	  temp_dir="/tmp/t/$1_$random_chars"
	  mkdir -p "$temp_dir" && cd "$temp_dir"
	fi
}

t
