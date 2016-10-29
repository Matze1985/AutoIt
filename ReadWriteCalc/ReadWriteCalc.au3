; Read line to file
$file = FileOpen(@ScriptDir & "\TempCalc.txt", 0) ; mode 0: read

; Check file
If $file = -1 Then
   MsgBox(0, "Error", "The file could not be opened.")
   Exit
EndIf

$numberLine = FileReadLine($file, 1) ; read line with number
$numberResultLine = $numberLine + 1 ; number + 1: final result

; Write line
$file = FileOpen(@ScriptDir & "\TempCalc.txt", 2) ; mode 2: write (erase previous contents)
FileWriteLine($file, $numberResultLine) ; write new number + 1 to file
MsgBox(0, "Result", $numberResultLine) ; result msgbox
FileClose($file)