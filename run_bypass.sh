#!/bin/bash
set -e

if ! command -v idevice_id &> /dev/null || ! command -v afcclient &> /dev/null; then
    echo "[-] Error: libimobiledevice tools missing."
    exit 1
fi

DEVICE_ID=$(idevice_id -l | head -n1)
if [ -z "$DEVICE_ID" ]; then
    echo "[-] Error: No device detected."
    exit 1
fi

PRODUCT_VERSION=$(ideviceinfo -u "$DEVICE_ID" -k ProductVersion)

if [[ "$PRODUCT_VERSION" == "9.3.5" ]]; then
    echo "[-] Unsupported: iOS 9.3.5 requires a SSH RAMDISK."
    exit 1
fi

IFS='.' read -r major minor patch <<< "$PRODUCT_VERSION"
if (( major < 7 )) || (( major > 9 )) || { (( major == 9 )) && (( minor > 3 )); } || { (( major == 9 )) && (( minor == 3 )) && (( patch > 4 )); }; then
    echo "[-] Unsupported Device: Only iOS 7.0 to 9.3.4 is supported."
    exit 1
fi

if ! afcclient -u "$DEVICE_ID" -r info / &> /dev/null; then
    echo "[-] Error: Device is Unjailbroken or AFC2 Not Installed."
    exit 1
fi

if ! afcclient -u "$DEVICE_ID" -r rename /Applications/Setup.app /Applications/Setup.app.bak &> /dev/null; then
    echo "[-] Error: Bypass Failed."
    exit 1
fi

echo "[+] Bypass & iCloud Bypass Successfully!"

if command -v idevicediagnostics &> /dev/null; then
    idevicediagnostics -u "$DEVICE_ID" restart &> /dev/null || true
else
    echo "[-] Error: Bypass Success, but idevicediagnostics missing for auto-reboot."
fi
