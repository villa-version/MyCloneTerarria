# Build and install SFML once into .deps/sfml-install/
# After this, cmake will use the pre-built version instead of compiling from source.
$ErrorActionPreference = "Stop"

$ProjectDir  = (Get-Item "$PSScriptRoot\..").FullName
$SfmlSrc     = "$ProjectDir\.deps\sfml-src"
$SfmlBuild   = "$ProjectDir\.deps\sfml-build"
$SfmlInstall = "$ProjectDir\.deps\sfml-install"
$SfmlTag     = "3.0.2"

if (Test-Path $SfmlInstall) {
    Write-Host "SFML already installed at $SfmlInstall"
    Write-Host "Delete that folder to rebuild."
    exit 0
}

if (-not (Test-Path $SfmlSrc)) {
    Write-Host "Cloning SFML $SfmlTag..."
    git clone --depth=1 --branch $SfmlTag https://github.com/SFML/SFML.git $SfmlSrc
}

Write-Host "Building SFML (this happens once)..."
cmake -B $SfmlBuild -S $SfmlSrc `
    -DCMAKE_BUILD_TYPE=Release `
    -DCMAKE_INSTALL_PREFIX=$SfmlInstall `
    -DSFML_BUILD_SHARED_LIBS=OFF `
    -DSFML_BUILD_EXAMPLES=OFF `
    -DSFML_BUILD_TEST_SUITE=OFF

cmake --build $SfmlBuild --config Release --parallel
cmake --install $SfmlBuild --config Release

Write-Host ""
Write-Host "Done. Run 'cmake -B build -S . && cmake --build build --config Release' to build the game."
