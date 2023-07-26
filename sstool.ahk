#SingleInstance force

SetWorkingDir, %A_ScriptDir%    

IniRead, dir, setting.ini, common, dir
IniRead, fname, setting.ini, common, fname

IniRead, pos1def, setting.ini, ss1, pos1def
IniRead, pos2def, setting.ini, ss1, pos2def
IniRead, pos3def, setting.ini, ss1, pos3def
IniRead, pos4def, setting.ini, ss1, pos4def

IniRead, pos5def, setting.ini, ss2, pos1def
IniRead, pos6def, setting.ini, ss2, pos2def
IniRead, pos7def, setting.ini, ss2, pos3def
IniRead, pos8def, setting.ini, ss2, pos4def

Gui, Add, Button, gCap1 Section, SHOT SCREEN（A）
onclick := msgbox a
Gui, Add, Edit, w50 xs+130 ys+0 vpos1, %pos1def%
Gui, Add, Edit, w50 xs+200 ys+0 vpos2, %pos2def%
Gui, Add, Edit, w50 xs+270 ys+0 vpos3, %pos3def%
Gui, Add, Edit, w50 xs+340 ys+0 vpos4, %pos4def%

Gui, Add, Button, xm+0 gCap2 Section, SHOT SCREEN（B）
Gui, Add, Edit, w50 xs+130 ys+0 vpos5, %pos5def%
Gui, Add, Edit, w50 xs+200 ys+0 vpos6, %pos6def%
Gui, Add, Edit, w50 xs+270 ys+0 vpos7, %pos7def%
Gui, Add, Edit, w50 xs+340 ys+0 vpos8, %pos8def%

Gui, Add, Text, xm+0 y+20 Section, 出力フォルダ名
Gui, Add, Edit, w200 xs+100 ys+0 vdir, %dir%

Gui, Add, Text, xs+0 Section, 先頭ファイル名
Gui, Add, Edit, w200 xs+100 ys+0 vfname, %fname%

Gui, Show
Return

Cap1:
Gui, Submit, NoHide
text := "powershell.exe -file ./ps/sstool.ps1 -pos1 " .  pos1 . " -pos2 " . pos2 . " -pos3 " . pos3 . " -pos4 " . pos4 . " -dir " . dir . " -fname " . fname
RunWait, %text%,,Hide
Return

Cap2:
Gui, Submit, NoHide
text := "powershell.exe -file ./ps/sstool.ps1 -pos1 " .  pos5 . " -pos2 " . pos6 . " -pos3 " . pos7 . " -pos4 " . pos8 . " -dir " . dir . " -fname " . fname
RunWait, %text%,,Hide
Return

!a::
	ControlClick, Button1, sstool.exe
	Return
!b::
	ControlClick, Button2, sstool.exe
	Return
