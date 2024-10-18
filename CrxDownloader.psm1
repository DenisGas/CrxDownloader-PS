function Get-ChromeVersion {
    <#
    .SYNOPSIS
    Retrieves the installed version of Google Chrome.

    .DESCRIPTION
    This function checks the Windows registry for the installed version of Google Chrome
    and returns it. If Chrome is not found, it returns $null.

    .OUTPUTS
    Returns the version of Chrome as a string, or $null if not found.

    .EXAMPLE
    Get-ChromeVersion
    129.0.6668.101
    #>

    param (
        [switch]$help
    )

    if ($help) {
        Get-Help Get-ChromeVersion -Full
        return
    }

    $chromeRegPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'

    if (Test-Path $chromeRegPath) {
        $chromePathInfo = Get-ItemProperty $chromeRegPath

        if ($chromePathInfo.'(Default)') {
            $chromePath = $chromePathInfo.'(Default)'
            $chromeVersionInfo = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($chromePath)
            $chromeVersion = $chromeVersionInfo.ProductVersion
            return $chromeVersion
        } else {
            Write-Host "Unable to retrieve version, '(Default)' is empty." -ForegroundColor Yellow
            return $null
        }
    } else {
        Write-Host "Chrome not found in the registry." -ForegroundColor Red
        return $null
    }
}
function Get-CrxFile {
    <#
    .SYNOPSIS
    Downloads a CRX file for a specified Chrome extension.

    .DESCRIPTION
    This function takes a URL of a Chrome extension and a save path,
    extracts the extension ID, determines the Chrome version, constructs a download URL,
    and downloads the CRX file to the specified location.

    .PARAMETER Url
    The URL of the Chrome extension page.

    .PARAMETER SavePath
    The local path where the CRX file will be saved. If not specified, defaults to the Downloads folder.

    .OUTPUTS
    Returns the path to the downloaded CRX file.

    .EXAMPLE
    Get-CrxFile -Url "https://chromewebstore.google.com/detail/jutsu-next-series/godmnckhgkgojikjpiahppfnmhgkfpjp?hl=ru" -SavePath "C:\Users\User\Downloads"
    #>

    param (
        [switch]$help,
        [string]$Url,
        [string]$SavePath = "$HOME\Downloads"
    )

    if ($help) {
        Get-Help Get-CrxFile -Full
        return
    }

    if ($SavePath -eq ".") {
        $SavePath = Get-Location
    }

    try {
        Write-Host "📥 Starting CRX file download process..." -ForegroundColor Green
        Write-Host "🔗 URL: $Url" -ForegroundColor Cyan

        if ($Url -match "/detail/") {
            $extId = $Url.Split("/")[-1].Split('?')[0]
            Write-Host "🆔 Extension ID: $extId" -ForegroundColor Yellow

            $extNameEncoded = ($Url -replace '.*/detail/', '').Split('/')[0]
            $extName = [System.Web.HttpUtility]::UrlDecode($extNameEncoded)
            Write-Host "📝 Extension Name: $extName" -ForegroundColor Yellow

            $chromeVersion = Get-ChromeVersion

            if (-not $chromeVersion) {
                $chromeVersion = "49.0"
                Write-Host "🔧 Chrome version not found. Using default version: $chromeVersion" -ForegroundColor Yellow
            } else {
                Write-Host "🌐 Chrome Version: $chromeVersion" -ForegroundColor Yellow
            }

            $chromeVersion = $chromeVersion.split(".")[0]

            $downloadUrl = "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=$chromeVersion&acceptformat=crx2,crx3&x=id%3D$extId%26installsource%3Dondemand%26uc"
            Write-Host "⬇️ Download URL: $downloadUrl" -ForegroundColor Cyan

            $date = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
            $fileName = "$extName-$date.crx"
            $filePath = "$SavePath\$fileName"

            Invoke-WebRequest -Uri $downloadUrl -OutFile $filePath
            Write-Host "✅ Extension downloaded successfully to $filePath" -ForegroundColor Green

            # Return the path to the downloaded CRX file
            return $filePath
        } else {
            Write-Host "❌ Invalid URL format." -ForegroundColor Red
            return $null
        }
    } catch {
        Write-error "⚠️ Error during download process: $_"
        return $null
    }
}

function Get-CrxFileAsZip {
    <#
    .SYNOPSIS
    Downloads a CRX file for a specified Chrome extension and renames it to a ZIP file.

    .DESCRIPTION
    This function takes a URL of a Chrome extension and a save path,
    downloads the CRX file using Get-CrxFile, and renames it to ZIP.

    .PARAMETER Url
    The URL of the Chrome extension page.

    .PARAMETER SavePath
    The local path where the ZIP file will be saved. If not specified, defaults to the Downloads folder.

    .OUTPUTS
    Returns the path to the renamed ZIP file.

    .EXAMPLE
    Get-CrxFileAsZip -Url "https://chromewebstore.google.com/detail/jutsu-next-series/godmnckhgkgojikjpiahppfnmhgkfpjp?hl=ru" -SavePath "C:\Users\User\Downloads"
    #>

    param (
        [switch]$help,
        [string]$Url,
        [string]$SavePath = "$HOME\Downloads"
    )

    if ($help) {
        Get-Help Get-CrxFileAsZip -Full
        return
    }

    if ($SavePath -eq ".") {
        $SavePath = Get-Location
    }

    try {
        # Use the Get-CrxFile function to download the CRX file
        $crxFilePath = Get-CrxFile -Url $Url -SavePath $SavePath

        if ($crxFilePath) {
            $zipFilePath = $crxFilePath -replace '\.crx$', '.zip'

            # Rename CRX to ZIP
            Rename-Item -Path $crxFilePath -NewName $zipFilePath
            Write-Host "✅ Renamed to ZIP: $zipFilePath" -ForegroundColor Green

            # Return the path to the renamed ZIP file
            return $zipFilePath
        } else {
            Write-Host "❌ CRX file was not downloaded." -ForegroundColor Red
            return $null
        }
    } catch {
        Write-error "⚠️ Error during renaming process: $_"
        return $null
    }
}

Export-ModuleMember -Function Get-CrxFileAsZip
Export-ModuleMember -Function Get-ChromeVersion
Export-ModuleMember -Function Get-CrxFile
