# AutoSleep Mod Build Script
# Builds both Mono and IL2CPP versions

Write-Host "[BUILD] Building AutoSleep Mod..." -ForegroundColor Cyan
Write-Host ""

# Check if .NET SDK is installed
$dotnetVersion = dotnet --version 2>$null
if (-not $dotnetVersion) {
    Write-Host "[ERROR] .NET SDK not found! Please install .NET 6.0 SDK" -ForegroundColor Red
    Write-Host "        Download from: https://dotnet.microsoft.com/download/dotnet/6.0" -ForegroundColor Yellow
    exit 1
}

Write-Host "[OK] .NET SDK found: $dotnetVersion" -ForegroundColor Green

# Check if required DLLs exist
$dllsExist = $true

if (-not (Test-Path "libs/MelonLoader.dll")) {
    Write-Host "[ERROR] Missing: libs/MelonLoader.dll" -ForegroundColor Red
    $dllsExist = $false
}

if (-not (Test-Path "libs/Il2CppInterop.Runtime.dll")) {
    Write-Host "[ERROR] Missing: libs/Il2CppInterop.Runtime.dll" -ForegroundColor Red
    $dllsExist = $false
}

if (-not (Test-Path "libs/Mono/Assembly-CSharp.dll")) {
    Write-Host "[ERROR] Missing: libs/Mono/Assembly-CSharp.dll" -ForegroundColor Red
    $dllsExist = $false
}

if (-not (Test-Path "libs/IL2CPP/Assembly-CSharp.dll")) {
    Write-Host "[ERROR] Missing: libs/IL2CPP/Assembly-CSharp.dll" -ForegroundColor Red
    $dllsExist = $false
}

if (-not (Test-Path "libs/UnityEngine.CoreModule.dll")) {
    Write-Host "[ERROR] Missing: libs/UnityEngine.CoreModule.dll" -ForegroundColor Red
    $dllsExist = $false
}

if (-not $dllsExist) {
    Write-Host ""
    Write-Host "[WARNING] You need to copy game DLLs first!" -ForegroundColor Yellow
    Write-Host "          See README.md 'Building From Source' section" -ForegroundColor Yellow
    exit 1
}

Write-Host "[OK] All required DLLs found" -ForegroundColor Green
Write-Host ""

# Build Mono version
Write-Host "[BUILD] Building Mono version..." -ForegroundColor Cyan
dotnet build -c Mono

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Mono build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Mono build successful!" -ForegroundColor Green
Write-Host ""

# Build IL2CPP version
Write-Host "[BUILD] Building IL2CPP version..." -ForegroundColor Cyan
dotnet build -c IL2CPP

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] IL2CPP build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] IL2CPP build successful!" -ForegroundColor Green
Write-Host ""

# Show output locations
Write-Host "[SUCCESS] Build complete!" -ForegroundColor Green
Write-Host ""
Write-Host "[OUTPUT] Files created:" -ForegroundColor Cyan
Write-Host "         Mono:    bin/Mono AutoSleep.dll" -ForegroundColor White
Write-Host "         IL2CPP:  bin/IL2CPP AutoSleep.dll" -ForegroundColor White
Write-Host ""

# Ask if user wants to copy to game folder
$gamePath = $env:AUTOSLEEP_GAME_PATH
if (-not $gamePath) {
    $defaultPath = "C:\Program Files (x86)\Steam\steamapps\common\Schedule I"
    Write-Host "[TIP] Set AUTOSLEEP_GAME_PATH environment variable to auto-copy to game folder" -ForegroundColor Yellow
    Write-Host ""
    
    $response = Read-Host "Copy to game Mods folder? (y/n)"
    if ($response -eq "y" -or $response -eq "Y") {
        $gamePath = Read-Host "Enter Schedule I installation path [$defaultPath]"
        if ([string]::IsNullOrWhiteSpace($gamePath)) {
            $gamePath = $defaultPath
        }
    }
}

if ($gamePath) {
    $modsPath = Join-Path $gamePath "Mods"
    
    if (Test-Path $modsPath) {
        # Ask which version to copy
        Write-Host ""
        Write-Host "Which version to copy?" -ForegroundColor Cyan
        Write-Host "1) Mono (main game branch)" -ForegroundColor White
        Write-Host "2) IL2CPP (alternate beta branch)" -ForegroundColor White
        Write-Host "3) Both" -ForegroundColor White
        $choice = Read-Host "Enter choice (1-3)"
        
        switch ($choice) {
            "1" {
                Copy-Item "bin/Mono AutoSleep.dll" -Destination $modsPath -Force
                Write-Host "[OK] Copied Mono version to $modsPath" -ForegroundColor Green
            }
            "2" {
                Copy-Item "bin/IL2CPP AutoSleep.dll" -Destination $modsPath -Force
                Write-Host "[OK] Copied IL2CPP version to $modsPath" -ForegroundColor Green
            }
            "3" {
                Copy-Item "bin/Mono AutoSleep.dll" -Destination "$modsPath/AutoSleep_Mono.dll" -Force
                Copy-Item "bin/IL2CPP AutoSleep.dll" -Destination "$modsPath/AutoSleep_IL2CPP.dll" -Force
                Write-Host "[OK] Copied both versions to $modsPath" -ForegroundColor Green
                Write-Host "[WARNING] Remember: Only use ONE version at a time!" -ForegroundColor Yellow
            }
            default {
                Write-Host "[ERROR] Invalid choice" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "[ERROR] Mods folder not found at: $modsPath" -ForegroundColor Red
        Write-Host "        Make sure MelonLoader is installed!" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[SUCCESS] Ready to test! Launch Schedule I and check the console!" -ForegroundColor Green
