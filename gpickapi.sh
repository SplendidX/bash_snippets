#!/usr/bin/env bash

# I want hex color codes

res=$(command -v gpick)
exit_code=$?

if [ $exit_code -eq 1 ]; then
    exit 1
fi

hex=$(gpick -s -o | sed 's/\#//g')
curl "https://www.thecolorapi.com/id?format=json&hex=$hex"
