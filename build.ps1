# ============================================================
#  build.ps1 - Production Build Script for Bank Manager
#  Produces a Windows NSIS installer at electron/dist/
# ============================================================

$ErrorActionPreference = "Stop"
$Root = $PSScriptRoot

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  CashBook - Production Build" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
# ----------------------------------------------------------
# Pre-Check: Symbolic Link Privileges
# ----------------------------------------------------------
# electron-builder needs to create symlinks for winCodeSign tools.
# This requires Developer Mode or Administrator privileges on Windows.
function Test-SymlinkPrivilege {
    $tempFile = Join-Path $env:TEMP "bm_symlink_test_$(Get-Random).tmp"
    $tempLink = Join-Path $env:TEMP "bm_symlink_test_$(Get-Random).tmp"
    try {
        New-Item -Path $tempFile -ItemType File -Value "test" -Force -ErrorAction Stop | Out-Null
        New-Item -Path $tempLink -ItemType SymbolicLink -Value $tempFile -Force -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    } finally {
        if (Test-Path $tempLink) { Remove-Item $tempLink -Force }
        if (Test-Path $tempFile) { Remove-Item $tempFile -Force }
    }
}

if (-not (Test-SymlinkPrivilege)) {
    Write-Host "ERROR: Missing Symbolic Link Privileges." -ForegroundColor Red
    Write-Host "The build requires the ability to create symbolic links." -ForegroundColor Yellow
    Write-Host "Please either:" -ForegroundColor Yellow
    Write-Host "  1. Enable 'Developer Mode' (Settings > Update & Security > For developers)" -ForegroundColor Yellow
    Write-Host "  2. Run this terminal as Administrator" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}


# ----------------------------------------------------------
# Step 1: Build React Frontend
# ----------------------------------------------------------
Write-Host "[Step 1/3] Building React frontend..." -ForegroundColor Yellow

Set-Location "$Root\frontend"
npm run build
if ($LASTEXITCODE -ne 0) { throw "Frontend build failed." }

Write-Host "[Step 1/3] Frontend built -> electron/ui/" -ForegroundColor Green

# ----------------------------------------------------------
# Step 2: Publish ASP.NET Backend (self-contained, win-x64)
# ----------------------------------------------------------
Write-Host ""
Write-Host "[Step 2/3] Publishing ASP.NET backend..." -ForegroundColor Yellow

$ApiOutput = "$Root\electron\resources\api"

Set-Location "$Root\backend"
dotnet publish backend\backend.csproj `
  --configuration Release `
  --runtime win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true `
  -p:PublishTrimmed=false `
  -p:DebugType=none `
  -p:DebugSymbols=false `
  -p:IncludeNativeLibrariesForSelfExtract=true `
  --output "$ApiOutput"

if ($LASTEXITCODE -ne 0) { throw "Backend publish failed." }

Write-Host "[Step 2/3] Backend published -> electron/resources/api/" -ForegroundColor Green

# ----------------------------------------------------------
# Step 3: Package with electron-builder
# ----------------------------------------------------------
Write-Host ""
Write-Host "[Step 3/3] Packaging with electron-builder..." -ForegroundColor Yellow

Set-Location "$Root\electron"

# Ensure electron dependencies are installed
if (-not (Test-Path "node_modules")) {
    Write-Host "  Installing electron dependencies..." -ForegroundColor DarkGray
    npm install
}

npm run dist
if ($LASTEXITCODE -ne 0) { throw "Electron packaging failed." }

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  BUILD COMPLETE!" -ForegroundColor Green
Write-Host "  Installer: electron\dist\CashBook Setup*.exe" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""

Set-Location $Root
