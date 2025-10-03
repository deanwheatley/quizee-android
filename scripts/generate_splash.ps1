<#
Generates splash screen PNGs for densities from a 512x512 (or arbitrary) source icon.
Creates centered icon on background color (#0B0F14 by default) with padding.

Usage:
  .\scripts\generate_splash.ps1 -Source .\assets\icon-512.png -BgColor '#0B0F14'

Outputs overwrite existing splash.png in:
  drawable-mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi

Dimensions chosen based on approximate pixel areas (can be adjusted):
  mdpi:    480x800
  hdpi:    720x1280
  xhdpi:   960x1600
  xxhdpi: 1080x1920
  xxxhdpi:1280x2160

Icon scaled to 40% of the min(screenWidth, screenHeight) to avoid oversizing.
#>
param(
  [string]$Source = './assets/icon-512.png',
  [string]$BgColor = '#0B0F14'
)

if(!(Test-Path $Source)){ Write-Error "Source '$Source' not found"; exit 1 }

Add-Type -AssemblyName System.Drawing

function New-Bitmap {
  param([int]$W,[int]$H,[string]$ColorHex)
  $bmp = New-Object System.Drawing.Bitmap($W,$H)
  $g=[System.Drawing.Graphics]::FromImage($bmp)
  $g.Clear([System.Drawing.Color]::FromArgb([Convert]::ToInt32($ColorHex.Substring(1,2),16),[Convert]::ToInt32($ColorHex.Substring(3,2),16),[Convert]::ToInt32($ColorHex.Substring(5,2),16)))
  $g.Dispose()
  return $bmp
}

function Draw-CenteredIcon {
  param($Canvas,$Icon)
  $g=[System.Drawing.Graphics]::FromImage($Canvas)
  $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $scale=[Math]::Min($Canvas.Width,$Canvas.Height)*0.4
  $x=($Canvas.Width-$scale)/2
  $y=($Canvas.Height-$scale)/2
  $g.DrawImage($Icon,$x,$y,$scale,$scale)
  $g.Dispose()
}

$targets = @(
  @{ dir='drawable-mdpi';   w=480;  h=800 },
  @{ dir='drawable-hdpi';   w=720;  h=1280 },
  @{ dir='drawable-xhdpi';  w=960;  h=1600 },
  @{ dir='drawable-xxhdpi'; w=1080; h=1920 },
  @{ dir='drawable-xxxhdpi';w=1280; h=2160 }
)

$icon=[System.Drawing.Image]::FromFile((Resolve-Path $Source))
try {
  foreach($t in $targets){
    $outPath = "app/src/main/res/$($t.dir)/splash.png"
    $canvas=New-Bitmap -W $t.w -H $t.h -ColorHex $BgColor
    Draw-CenteredIcon -Canvas $canvas -Icon $icon
    $canvas.Save($outPath,[System.Drawing.Imaging.ImageFormat]::Png)
    $canvas.Dispose()
    Write-Host "Wrote $outPath ($($t.w)x$($t.h))"
  }
} finally {
  $icon.Dispose()
}

Write-Host "Splash images regenerated. Rebuild the app to include them." 
