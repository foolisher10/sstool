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

#���̃J�[�\���擾
$ArrowCursor = [System.Windows.Forms.Cursors]::Arrow
#���݂̃J�[�\���ʒu�擾
$cursorPosition=[System.Windows.Forms.Cursor]::Position

#DPI Scaling�̎擾
$DPISetting = (Get-ItemProperty 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name AppliedDPI).AppliedDPI
switch ($DPISetting){
	96 {$ActualDPI = 100}
	120 {$ActualDPI = 125}
	144 {$ActualDPI = 150}
	192 {$ActualDPI = 200}
}
[float]$DisplayScale=($ActualDPI /100)

#�J�[�\���ʒu�␳�i�X�P�[�����O�Ή��j
[float]$PositionX=(($CursorPosition.x)*$DisplayScale)
[float]$PositionY=(($CursorPosition.y)*$DisplayScale)

#��`����
$Rectangle = New-Object -TypeName System.Drawing.Rectangle(($PositionX-$pos1),($PositionY-$pos2),0,0)
#�J�[�\��������
$ArrowCursor.Draw($graphic,$Rectangle)

if (-Not (Test-Path $dir)) {
    mkdir $dir
}

$path = ".\" + $dir
$path = Convert-Path $path
$bmp.Save($path + "\" + $fname +"_$(get-date -Format 'yyyyMMdd-hhmmss').png")

$graphic.Dispose()
$bmp.Dispose()

#debug
#[System.Windows.Forms.MessageBox]::Show(($PositionX-$pos1))
