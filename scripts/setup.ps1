# One-shot setup: installs prerequisites, builds SFML, and builds the game
$ErrorActionPreference = "Stop"

function Has-Command($cmd) {
    return [bool](Get-Command $cmd -ErrorAction SilentlyContinue)
}

function Refresh-Path {
    $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("PATH", "User")
}

# Install CMake if missing
if (-not (Has-Command "cmake")) {
    Write-Host "Installing CMake via winget..."
    winget install --id Kitware.CMake -e --accept-source-agreements --accept-package-agreements
    Refresh-Path
}

# Install Git if missing
if (-not (Has-Command "git")) {
    Write-Host "Installing Git via winget..."
    winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
    Refresh-Path
}

# Install Visual Studio Build Tools (C++ workload) if cl.exe not found
if (-not (Has-Command "cl")) {
    Write-Host "Installing Visual Studio 2022 Build Tools (C++ workload)..."
    Write-Host "This is a large download (~2 GB) and may take several minutes."
    winget install --id Microsoft.VisualStudio.2022.BuildTools -e --accept-source-agreements --accept-package-agreements `
        --override "--quiet --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
    Refresh-Path
}

Write-Host "cmake: $(cmake --version | Select-Object -First 1)"
Write-Host "git:   $(git --version)"

$ProjectDir = (Get-Item "$PSScriptRoot\..").FullName

# Build SFML in a fresh shell so newly installed tools are on PATH
pwsh -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\build-deps.ps1"

# Build the game
Write-Host ""
Write-Host "Building the game..."
cmake -B "$ProjectDir\build" -S "$ProjectDir" -G "Visual Studio 17 2022" -A x64
cmake --build "$ProjectDir\build" --config Release --parallel

Write-Host ""
Write-Host "Done! Run the game with:"
Write-Host "  $ProjectDir\build\Release\MyCloneTerraria.exe"
