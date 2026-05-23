# 📱 afc2-setup-killer

A minimal, open-source Bash toolchain to disable the stock setup assistant (`Setup.app`) on legacy jailbroken iOS devices using native Apple File Conduit 2 (AFC2) connections over USB. No OpenSSH configuration required.

## ⚠️ IMPORTANT NOTICE & DISCLAIMER
* **🎓 Educational Purposes Only:** This project is created strictly for academic research, device preservation, and educational purposes.
* **🔒 No Software Theft:** This tool does not bypass remote management activation locks or source intellectual property. It simply alters local filesystem references on hardware you physically own.
* **🛡️ Warranty:** Use at your own risk. The authors are not responsible for any bootloops, data loss, or bricked devices.

## 📊 Compatibility Matrix


| iOS Version | Status | Requirement / Note |
| :--- | :---: | :--- |
| **iOS 1.0 - 6.1.6** | ❌ | Unsupported by this tool architecture. |
| **iOS 7.0 - 9.3.4** | ✅ | **Supported** (Requires Jailbreak + AFC2 package). |
| **iOS 9.3.5** | ❌ | **Unsupported.** Requires a specialized SSH RAMDISK (Use **Legacy iOS Kit** instead). |
| **iOS 10.0+** | ❌ | Unsupported. Modern activation structures applied. |

| Chipset Architecture | Status | Supported Devices (Examples) |
| :--- | :---: | :--- |
| **A5 / A5X** | ✅ | iPhone 4S, iPad 2, iPad 3, iPad Mini 1, iPod Touch 5 |
| **A6 / A6X** | ✅ | iPhone 5, iPhone 5C, iPad 4 |
| **A7** | ✅ | iPhone 5S, iPad Air 1, iPad Mini 2, iPad Mini 3 |
| **A8 / A8X** | ✅ | iPhone 6, iPhone 6 Plus, iPad Air 2, iPad Mini 4 |
| **A9 / A9X** | ✅ | iPhone 6S, iPhone 6S Plus, iPhone SE (1st Gen), iPad Pro |

---

## 💻 Host Prerequisites & Installation

### 1. 🍏 macOS Setup (Installing Homebrew & Dependencies)

If your Mac does not have **Homebrew** installed, open your terminal and run the official setup string:
```bash
/bin/bash -c "\$(curl -fsSL https://githubusercontent.com)"
```

Once Homebrew is active, install the required `libimobiledevice` components and binary protocols by executing:
```bash
brew install libimobiledevice ideviceinstaller
```

### 2. 🐧 Linux Setup (Ubuntu/Debian)

Update your package tree and install the official native builds directly:
```bash
sudo apt-get update
sudo apt-get install -y libimobiledevice-utils ideviceinstaller
```

---

## 🚀 Deployment Instructions

1. 📂 Clone or download this repository locally.
2. 🔌 Ensure your legacy target device is connected via a secure USB cable.
3. 🔑 Mark the script workspace as executable:
   ```bash
   chmod +x *.sh
   ```
4. ⚙️ Run the automated local dependency and environment check:
   ```bash
   ./install_deps.sh
   ```
5. 📦 Deploy the automatic Cydia package installation framework:
   ```bash
   ./AFC.sh
   ```
6. 🎯 Execute the final core application filesystem patcher:
   ```bash
   ./run_bypass.sh
   ```
git add README.md
git commit -m "Add compatibility markdown tables to README"
git push origin main
