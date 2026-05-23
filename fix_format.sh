#!/bin/bash
set -e

# Install dos2unix if missing
if ! command -v dos2unix &> /dev/null; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            brew install dos2unix
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y dos2unix
    fi
fi

# Convert all script files to LINUX/UNIX/MAC/IPHONE LF format
if command -v dos2unix &> /dev/null; then
    dos2unix *.sh
else
    # Fallback to sed if installation failed
    for file in *.sh; do
        if [ -f "$file" ]; then
            sed -i.bak 's/\r$//' "$file" && rm -f "${file}.bak"
        fi
    done
fi

# Make all shell scripts executable
chmod +x *.sh
