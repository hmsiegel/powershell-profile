$profilePath = $PROFILE.CurrentUserCurrentHost
$profileDir = Split-Path -Path $profilePath -Parent
$sourcePath = Join-Path -Path $PSScriptRoot -ChildPath 'Microsoft.PowerShell_profile.ps1'

if (-not (Test-Path -Path $sourcePath -PathType Leaf)) {
    throw "Profile source file not found: $sourcePath"
}

if (-not (Test-Path -Path $profileDir)) {
    New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
}

Copy-Item -Path $sourcePath -Destination $profilePath -Force

# Keep the oh-my-posh theme next to the profile so startup doesn't need the network
$themeSource = Join-Path -Path $PSScriptRoot -ChildPath 'hmsiegel.omp.json'
if (Test-Path -Path $themeSource -PathType Leaf) {
    Copy-Item -Path $themeSource -Destination (Join-Path $profileDir 'hmsiegel.omp.json') -Force
}
