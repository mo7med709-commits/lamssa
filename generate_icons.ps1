
Add-Type -AssemblyName System.Drawing

# Source image - the lamsat icon provided by user
$sourcePath = "c:\Users\pc\Pictures\Lamsa user\lamsa_icon_source.png"
$outputDir = "c:\Users\pc\Pictures\Lamsa user\ios\Runner\Assets.xcassets\AppIcon.appiconset"

# All required iOS icon sizes
$sizes = @(16, 20, 29, 32, 40, 48, 50, 55, 57, 58, 60, 64, 72, 76, 80, 87, 88, 100, 114, 120, 128, 144, 152, 167, 172, 180, 196, 216, 256, 512, 1024)

$sourceImage = [System.Drawing.Image]::FromFile($sourcePath)

foreach ($size in $sizes) {
    $destPath = Join-Path $outputDir "$size.png"
    
    $bitmap = New-Object System.Drawing.Bitmap($size, $size)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    
    $graphics.DrawImage($sourceImage, 0, 0, $size, $size)
    
    $bitmap.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $graphics.Dispose()
    $bitmap.Dispose()
    
    Write-Host "Generated: $size.png"
}

$sourceImage.Dispose()
Write-Host "All icons generated successfully!"
