# === MW4 Auto Updater ===

$ErrorActionPreference = "Stop"

$src = "$env:USERPROFILE\Downloads\MW4-Files"
$dst = "$env:LOCALAPPDATA\Activision\Call of Duty\playersBeta"

try {
    # Create folders if required
    New-Item -ItemType Directory -Force -Path $src | Out-Null
    New-Item -ItemType Directory -Force -Path $dst | Out-Null

    # MW4 config files
    $files = @(
        @{
            url  = "https://raw.githubusercontent.com/xijammy/mw4configs/main/s.1.1.bt.cod26.txt"
            name = "s.1.1.bt.cod26.txt"
        }
    )

    # Download latest files
    foreach ($f in $files) {
        $out = Join-Path $src $f.name

        Invoke-WebRequest `
            -Uri $f.url `
            -OutFile $out `
            -UseBasicParsing

        Write-Host "Downloaded $($f.name)"
    }

    # Copy latest configs into MW4 playersBeta
    foreach ($f in $files) {
        $sourceFile = Join-Path $src $f.name
        $destinationFile = Join-Path $dst $f.name

        Copy-Item $sourceFile $destinationFile -Force
    }

    Write-Host ""
    Write-Host "MW4 configuration files replaced successfully."

    exit 0
}
catch {
    Write-Host ""
    Write-Host "MW4 configuration update failed."
    Write-Host $_.Exception.Message

    exit 1
}
