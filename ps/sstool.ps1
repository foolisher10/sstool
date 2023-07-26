Param(
    [Int]$pos1,
    [Int]$pos2,
    [Int]$pos3,
    [Int]$pos4,
    [String]$dir,
    [String]$fname
)

Add-Type -AssemblyName System.Windows.Forms,System.Drawing

$rect=[Drawing.Rectangle]::FromLTRB($pos1,$pos2,$pos3,$pos4)

$bmp=New-Object System.Drawing.Bitmap $rect.width,$rect.height
$graphic=[System.Drawing.Graphics]::FromImage($bmp)

($graphic).CopyFromscreen($rect.left,$rect.top,0,0,$bmp.size)

#矢印のカーソル取得
$ArrowCursor = [System.Windows.Forms.Cursors]::Arrow
#現在のカーソル位置取得
$cursorPosition=[System.Windows.Forms.Cursor]::Position
#矩形生成
$Rectangle = New-Object -TypeName System.Drawing.Rectangle($CursorPosition.x,$CursorPosition.y,0,0)
#カーソル書込み
$ArrowCursor.Draw($graphic,$Rectangle)

if (-Not (Test-Path $dir)) {
    mkdir $dir
}

$path = ".\" + $dir
$path = Convert-Path $path
$bmp.Save($path + "\" + $fname +"_$(get-date -Format 'yyyyMMdd-hhmmss').png")

$bmp.Dispose()