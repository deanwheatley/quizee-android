<#
Generates Android launcher mipmap icons from a 512x512 master PNG.

Usage (from repo root PowerShell):
  pwsh -File .\scripts\generate_icons.ps1 -Source .\icon-512.png

If -Source not provided, defaults to .\icon-512.png

Outputs (overwrites):
  app/src/main/res/mipmap-mdpi/ic_launcher.png  (48x48)
  app/src/main/res/mipmap-hdpi/ic_launcher.png  (72x72)
  app/src/main/res/mipmap-xhdpi/ic_launcher.png (96x96)
  app/src/main/res/mipmap-xxhdpi/ic_launcher.png (144x144)
  app/src/main/res/mipmap-xxxhdpi/ic_launcher.png (192x192)

You can also pass -StoreIcon to overwrite store_icon.png at repo root.

NOTE: Requires .NET (System.Drawing). If you encounter GDI+ issues on non-Windows, switch to ImageMagick or Sharp (Node) as needed.
#>
param(
    [string]$Source = "./icon-512.png",
    [switch]$StoreIcon
)

if (!(Test-Path $Source)) {
    Write-Error "Source image '$Source' not found. Place the 512x512 icon at that path or pass -Source."; exit 1
}

Add-Type -AssemblyName System.Drawing

function Resize-Icon {
    param(
        [System.Drawing.Image]$Image,
        [int]$Size,
        [string]$OutPath
    )
    $bmp = New-Object System.Drawing.Bitmap($Size, $Size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.DrawImage($Image, 0, 0, $Size, $Size)
    $g.Dispose()
    $dir = Split-Path $OutPath -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    $bmp.Save($OutPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Wrote $OutPath ($Size x $Size)"
}

$targetMap = @{
    "app/src/main/res/mipmap-mdpi/ic_launcher.png"  = 48
    "app/src/main/res/mipmap-hdpi/ic_launcher.png"  = 72
    "app/src/main/res/mipmap-xhdpi/ic_launcher.png" = 96
    "app/src/main/res/mipmap-xxhdpi/ic_launcher.png"= 144
    "app/src/main/res/mipmap-xxxhdpi/ic_launcher.png"=192
}

try {
    $img = [System.Drawing.Image]::FromFile((Resolve-Path $Source))
    if ($img.Width -ne 512 -or $img.Height -ne 512) {
        Write-Warning "Source image is ${($img.Width)}x${($img.Height)}; recommended 512x512. Scaling anyway."
    }
    foreach ($kvp in $targetMap.GetEnumerator()) {
        Resize-Icon -Image $img -Size $kvp.Value -OutPath $kvp.Key
    }
    if ($StoreIcon) {
        Copy-Item -Path $Source -Destination 'store_icon.png' -Force
        Write-Host "Updated store_icon.png"
    }
} finally {
    if ($img) { $img.Dispose() }
}

Write-Host "Done. Rebuild the project to package new icons."
