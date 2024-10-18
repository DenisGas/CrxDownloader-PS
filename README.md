# CrxDownloader-PS

This PowerShell module provides functions to retrieve the installed version of Google Chrome and to download `.crx` files (Chrome extensions) directly from the Chrome Web Store.


## Requirements

![PowerShell](https://img.shields.io/badge/PowerShell-7%2B-blue?logo=powershell)

- PowerShell >= 7.0

## Preview
![image](https://github.com/user-attachments/assets/65446f05-288c-4ad1-acc7-fdb89198e2f9)


## Features:
- **`Get-ChromeVersion`**: Retrieves the installed version of Google Chrome from the Windows registry.
- **`Get-CrxFile`**: Downloads a `.crx` file for a specified Chrome extension from the Chrome Web Store using its URL.

---

## Installation

To use this module, you can either clone this repository and import the module locally or download the module directly into PowerShell.

### Option 1: Clone the repository

1. Clone the repository:
   ```sh
   git clone https://github.com/DenisGas/CrxDownloader-PS.git
   ```
2. Navigate to the cloned folder and import the module into your session:
   ```sh
   Import-Module ./CrxDownloader.psm1
   ```

### Option 2: Direct Download and Import

1. Download the [`.psm1`](CrxDownloader.psm1) file from GitHub.
2. Import the module directly:
   ```sh
   Import-Module ./path-to-module/CrxDownloader.psm1
   ```

### Option 3: Remote Import (Experimental)

If you want to import this module directly from GitHub (without downloading it locally first), you can try the following (though this depends on your environment's policies and security configurations):

1. Use `Invoke-WebRequest` to download the module directly into your PowerShell session:
   ```powershell
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DenisGas/CrxDownloader-PS/main/CrxDownloader.psm1" -OutFile "$env:TEMP\CrxDownloader.psm1"
   Import-Module "$env:TEMP\CrxDownloader.psm1"
   ```

---

Here's the updated documentation for the `Get-CrxFile`, `Get-CrxFileAsZip`, and existing `Get-ChromeVersion` functions:

## Usage

### 1. **Get-ChromeVersion**
This function retrieves the installed version of Google Chrome from the Windows registry.

**Example**:
```powershell
Get-ChromeVersion
```

**Output**:
- If Chrome is found, it will display the version, for example:
  ```
  129.0.6668.101
  ```
- If Chrome is not found, the function will return `null`.

---

### 2. **Get-CrxFile**
This function downloads a `.crx` file for a specified Chrome extension using the extension URL and an optional save path.

**Parameters**:
- **Url (required)**: The URL of the Chrome extension page (e.g., from the Chrome Web Store).
- **SavePath (optional)**: The local path where the `.crx` file should be saved. Defaults to the user's Downloads folder. You can also use `"."` to save the file in the current directory.

**Example**:
```powershell
Get-CrxFile -Url "https://chromewebstore.google.com/detail/jutsu-next-series/godmnckhgkgojikjpiahppfnmhgkfpjp?hl=ru" -SavePath "C:\Users\User\Downloads"
```
This will download the `.crx` file for the specified extension to the given folder.

**Default Behavior**:
- If Chrome is installed, the function will attempt to match the current version of Chrome for downloading the appropriate extension version.
- If Chrome is not found, it defaults to version `49.0`.

---

### 3. **Get-CrxFileAsZip**
This function downloads a `.crx` file for a specified Chrome extension and automatically changes the file extension to `.zip`.

**Parameters**:
- **Url (required)**: The URL of the Chrome extension page (e.g., from the Chrome Web Store).
- **SavePath (optional)**: The local path where the `.zip` file should be saved. Defaults to the user's Downloads folder. You can also use `"."` to save the file in the current directory.

**Example**:
```powershell
Get-CrxFileAsZip -Url "https://chromewebstore.google.com/detail/jutsu-next-series/godmnckhgkgojikjpiahppfnmhgkfpjp?hl=ru" -SavePath "C:\Users\User\Downloads"
```
This command will download the `.crx` file for the specified extension, and automatically change its extension to `.zip`.

### Default Behavior**:
- If Chrome is installed, the function will attempt to match the current version of Chrome for downloading the appropriate extension version.
- If Chrome is not found, it defaults to version `49.0`.

### Important Notes:
1. Both functions (`Get-CrxFile` and `Get-CrxFileAsZip`) use the version of Chrome to construct the correct URL for downloading the CRX file.
2. If no version of Chrome is found, version `49.0` is used by default for compatibility.

---

## Notes:
- **Module Export**: This module exports both `Get-ChromeVersion` and `Get-CrxFile` functions. You can use these directly after importing the module.
- **Error Handling**: Both functions contain basic error handling and will display relevant messages for troubleshooting.

