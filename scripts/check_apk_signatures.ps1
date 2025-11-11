# Requires: aapt.exe and apksigner.bat in your PATH or specify their full paths below
# Edit these paths if needed

$AAPT = "C:\\android\\Sdk\\build-tools\\36.1.0-rc1\\aapt.exe"
$APKSIGNER = "C:\\android\\Sdk\\build-tools\\36.1.0-rc1\\apksigner.bat"

$prodApk = "..\app\build\outputs\apk\production\release\app-production-release.apk"
$intApk  = "..\app\build\outputs\apk\integration\release\app-integration-release.apk"

Write-Host "=== Production APK ==="
& $AAPT dump badging $prodApk | Select-String "package:"
& $APKSIGNER verify --print-certs $prodApk

Write-Host "\n=== Integration APK ==="
& $AAPT dump badging $intApk | Select-String "package:"
& $APKSIGNER verify --print-certs $intApk
