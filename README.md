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

## Usage

### 1. `Get-ChromeVersion`

This function retrieves the installed version of Google Chrome from the Windows registry.

#### Example:
```powershell
Get-ChromeVersion
```

**Output**:  
If Chrome is found, the version will be displayed as:
```plaintext
129.0.6668.101
```
If Chrome is not found, the function will return `null`.

### 2. `Get-CrxFile`

This function downloads a `.crx` file for a specified Chrome extension by providing the extension URL and an optional save path.

#### Parameters:
- **`Url`** (required): The URL of the Chrome extension (e.g., from the Chrome Web Store).
- **`SavePath`** (optional): The local path where the `.crx` file should be saved. Defaults to the user's Downloads folder if not provided. Can also use `"."` to save to the current directory.

#### Example:
```powershell
Get-CrxFile -Url "https://chromewebstore.google.com/detail/jutsu-next-series/godmnckhgkgojikjpiahppfnmhgkfpjp?hl=ru" -SavePath "C:\Users\User\Downloads"
```

This will download the `.crx` file for the extension to the specified folder.

#### Default Behavior:
- If Chrome is installed, the function will attempt to match the current version for download.
- If Chrome is not found, it defaults to version `49.0`.

---

## Notes:
- **Module Export**: This module exports both `Get-ChromeVersion` and `Get-CrxFile` functions. You can use these directly after importing the module.
- **Error Handling**: Both functions contain basic error handling and will display relevant messages for troubleshooting.

