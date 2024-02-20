#!/bin/bash
test -n "$1" || { echo "no input provided"; exit 1; }

openssl enc -d -aes-256-cbc -pbkdf2 -iter 1000000 -salt -in "$1"
