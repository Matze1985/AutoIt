#include <MsgBoxConstants.au3>
#include <File.au3>

; Read textfile
$file= "PingList.txt"
FileOpen($file, 0)

; Write logfile
$hFile = "PingList.log"
FileOpen($hfile, 1)
FileWriteLine ($hFile, "Time;State;Host;Roundtrip-time;ErrorMsg" & @CRLF) ; CSV line 1 for filter

; Check textfile
If $file = -1 Then
    MsgBox(0, "Error", "Textfile not found!")
    Exit
EndIf

; Ping line by line
For $i = 1 to _FileCountLines($file)
   $line = FileReadLine($file, $i)
   $iPing = Ping($line, 250)
    If $iPing Then ; If a value greater than 0 was returned then display the following message.
         _FileWriteLog($hFile, "OK;" & $line & ";" & $iPing & " ms")
    Else
        _FileWriteLog($hFile, "NOK;" & $line & ";" & ";Code " & @error) ; @error
   EndIf
Next

FileClose($file & $hFile)

; Logfile to CSV-File
Local $sFind = " : "
Local $sReplace = ";"

; Set ErrMsg Code 1
Local $sFindErrOne = "Code 1"
Local $sReplaceErrOne = "Host is offline"

; Set ErrMsg Code 2
Local $sFindErrTwo = "Code 2"
Local $sReplaceErrTwo = "Host is unreachable"

; Set ErrMsg Code 3
Local $sFindErrThree = "Code 3"
Local $sReplaceErrThree = "Bad destination"

; Set ErrMsg Code 4
Local $sFindErrFour = "Code 4"
Local $sReplaceErrFour = "Other errors"

; Logfile find and replace
Local $iRetval = _ReplaceStringInFile($hFile, $sFind, $sReplace)
Local $iRetval = _ReplaceStringInFile($hFile, $sFindErrOne, $sReplaceErrOne)
Local $iRetval = _ReplaceStringInFile($hFile, $sFindErrTwo, $sReplaceErrTwo)
Local $iRetval = _ReplaceStringInFile($hFile, $sFindErrThree, $sReplaceErrThree)
Local $iRetval = _ReplaceStringInFile($hFile, $sFindErrFour, $sReplaceErrFour)

; Log to csv
FileMove($hFile, "PingList.csv", 1)