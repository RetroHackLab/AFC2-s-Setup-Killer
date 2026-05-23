#!/bin/bash
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "[-] Error: Homebrew is required."
        exit 1
    fi
    brew install libimobiledevice ideviceinstaller
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update && sudo apt-get install -y libimobiledevice-utils ideviceinstaller
else
    echo "[-] Error: Unsupported OS."
    exit 1
fi
