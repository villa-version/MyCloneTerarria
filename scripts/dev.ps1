# Dev workflow: watch for changes, rebuild and restart the game
$ErrorActionPreference = "Stop"

$ProjectDir = (Get-Item "$PSScriptRoot\..").FullName
$BuildDir   = "$ProjectDir\build"
$SrcDir     = "$ProjectDir\src"

# Handle both single-config (Ninja) and multi-config (VS) generators
function Get-Binary {
    if (Test-Path "$BuildDir\MyCloneTerraria.exe")       { return "$BuildDir\MyCloneTerraria.exe" }
    if (Test-Path "$BuildDir\Debug\MyCloneTerraria.exe") { return "$BuildDir\Debug\MyCloneTerraria.exe" }
    return $null
}

$GameProcess = $null

function Build {
    Write-Host "[dev] Building..."
    cmake -B $BuildDir -S $ProjectDir
    if ($LASTEXITCODE -ne 0) { Write-Host "[dev] cmake configure failed"; return $false }
    cmake --build $BuildDir --config Debug --parallel
    if ($LASTEXITCODE -ne 0) { Write-Host "[dev] build failed"; return $false }
    Write-Host "[dev] Build complete."
    return $true
}

function StartGame {
    $bin = Get-Binary
    if (-not $bin) { Write-Host "[dev] Binary not found"; return }
    $binDir = Split-Path $bin
    Write-Host "[dev] Starting game..."
    $script:GameProcess = Start-Process -FilePath $bin -WorkingDirectory $binDir -PassThru
    Write-Host "[dev] Game PID: $($script:GameProcess.Id)"
}

function StopGame {
    if ($script:GameProcess -and -not $script:GameProcess.HasExited) {
        Write-Host "[dev] Stopping game (PID $($script:GameProcess.Id))..."
        $script:GameProcess.Kill()
        $script:GameProcess.WaitForExit()
    }
    $script:GameProcess = $null
}

# Ctrl+C cleanup
[Console]::TreatControlCAsInput = $false
$null = Register-EngineEvent PowerShell.Exiting -Action { StopGame }

Set-Location $ProjectDir

if (Build) { StartGame }

Write-Host "[dev] Watching $SrcDir for changes..."

$watcher = New-Object System.IO.FileSystemWatcher $SrcDir
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

try {
    while ($true) {
        $change = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::All, 1000)

        if ($script:GameProcess -and $script:GameProcess.HasExited) {
            Write-Host "[dev] Game exited."
            $script:GameProcess = $null
        }

        if (-not $change.TimedOut) {
            Start-Sleep -Milliseconds 200  # debounce
            Write-Host "[dev] Change detected ($($change.Name)), rebuilding..."
            StopGame
            if (Build) { StartGame }
        }
    }
} finally {
    StopGame
    $watcher.Dispose()
}
