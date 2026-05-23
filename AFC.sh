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
DEB_FILE="debs/com.saurik.afc2d_1.2_iphoneos-arm.deb"

if [ ! -f "$DEB_FILE" ]; then
    echo "[-] Error: DEB file missing in /debs/"
    exit 1
fi

afcclient -u "$DEVICE_ID" mkdir /Media/Cydia &> /dev/null || true
afcclient -u "$DEVICE_ID" mkdir /Media/Cydia/AutoInstall &> /dev/null || true
afcclient -u "$DEVICE_ID" put "$DEB_FILE" /Media/Cydia/AutoInstall/com.saurik.afc2d_1.2_iphoneos-arm.deb

if command -v idevicediagnostics &> /dev/null; then
    idevicediagnostics -u "$DEVICE_ID" restart &> /dev/null || true
else
    echo "[-] Error: idevicediagnostics missing."
    exit 1
fi

# Wait for device to disconnect and reconnect (Reboot 1)
sleep 15
while ! idevice_id -l | grep -q "$DEVICE_ID"; do
    sleep 2
done
sleep 10

# Trigger Second Reboot
idevicediagnostics -u "$DEVICE_ID" restart &> /dev/null || true

# Wait for device to disconnect and reconnect (Reboot 2)
sleep 15
while ! idevice_id -l | grep -q "$DEVICE_ID"; do
    sleep 2
done

if ! afcclient -u "$DEVICE_ID" -r info / &> /dev/null; then
    echo "[-] Error: AFC2 installation failed."
    exit 1
fi
