Param(
    [Int]$pos1,
    [Int]$pos2,
    [Int]$pos3,
    [Int]$pos4
)

Add-Type -AssemblyName System.Windows.Forms,System.Drawing

#$rect=[Drawing.Rectangle]::FromLTRB(-1920,5,-20,1033)
$rect=[Drawing.Rectangle]::FromLTRB($pos1,$pos2,$pos3,$pos4)

$bmp=New-Object System.Drawing.Bitmap $rect.width,$rect.height
([System.Drawing.Graphics]::FromImage($bmp)).CopyFromscreen($rect.left,$rect.top,0,0,$bmp.size)

if (-Not (Test-Path "./dest")) {
    mkdir "./dest"
}

$path = Convert-Path ".\dest"
$bmp.Save($path + "\P$(get-date -Format 'yyyyMMdd-hhmmss').png")

$bmp.Dispose()