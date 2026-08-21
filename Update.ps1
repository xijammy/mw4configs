# === MW4 Auto Updater ===

# Where to temporarily download the files
$src = "$env:USERPROFILE\Downloads\MW4-Files"

# The Call of Duty Players folder (hidden but accessible)
$dst = "$env:LOCALAPPDATA\Activision\Call of Duty\playersBeta"

# Make sure the temporary folder exists
New-Item -ItemType Directory -Force -Path $src | Out-Null

# List of files to download (RAW links!)
$files = @(
    @{ url = "https://raw.githubusercontent.com/xijammy/mw4configs/main/s.1.0.bt.cod26.txt"; name = "s.1.0.bt.cod26.txt" }

)

# Download each file
foreach ($f in $files) {
    $out = Join-Path $src $f.name
    Invoke-WebRequest -Uri $f.url -OutFile $out
    Write-Host "Downloaded $($f.name)"
}

# Replace files inside the MW4 Players folder
Copy-Item "$src\*" $dst -Force

Write-Host "`n✔ MW4 configuration files replaced successfully."