; Read line to file
$file = FileOpen(@ScriptDir & "\TempCalc.txt", 0) ; mode 0: read

; Check file
If $file = -1 Then
     MsgBox(0, "Error", "The file could not be opened.")
     Exit
  EndIf

$number_line = FileReadLine($file, 1) ; read line with number
$number_result_line = $number_line + 1 ; number + 1: final result

; Write line
$file = FileOpen(@ScriptDir & "\TempCalc.txt", 2) ; mode 2: write (erase previous contents)
FileWriteLine($file, $number_result_line) ; write new number + 1 to file
MsgBox(0, "Result", $number_result_line) ; result msgbox
FileClose($file)