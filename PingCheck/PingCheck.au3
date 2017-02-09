#include <MsgBoxConstants.au3>
#include <File.au3>

; textfile
$file = "PingList.txt"

; Check textfile
Local $iFileExists = FileExists($file)

If Not $iFileExists Then
   MsgBox($MB_ICONERROR, "Error", "Wrong reading for the hosts textfile!")
   Exit
EndIf

; CSV file
$fileCsv = @DesktopDir & "\PingList.csv"
FileDelete ($fileCsv) ; remove the old file

; CSV file tmp
$fileCsvTmp = @TempDir & "\CsvMsg.tmp"

; logfile
$hFile = @TempDir & "\PingList.log"
FileWriteLine ($hFile, "Time : Host : Description : Roundtrip-time : State") ; CSV line 1 for filter

; Start loop
For $i = 1 to _FileCountLines($file)
   $line = FileReadLine($file, $i)

   ; Split the string with ";"
   $string = $line
   $aSplit = StringSplit($string, ";")

   ; Ping line by line
   $iPing = Ping($aSplit[1], 250)
    If $iPing Then ; If a value greater than 0 was returned then display the following message.
         _FileWriteLog($hFile, $aSplit[1] & " : " & $aSplit[2] & " : " & $iPing & " ms" & " : OK")
    Else
        _FileWriteLog($hFile, $aSplit[1] & " : " & $aSplit[2] & " : " & " : Code " & @error)
   EndIf
Next

Local $iFileExists = FileExists($fileCsv) ; Remove old csv file; Log to csv
If $iFileExists Then
   FileDelete ($hFile) ; remove the old logfile
   MsgBox($MB_ICONERROR, "Error", "" & @CRLF & "File is open and exists with the same name, please change or delete the file and try again!")
   Exit
EndIf

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

FileMove($hFile, $fileCsv, 1) ; Log to csv
FileCopy($fileCsv, $fileCsvTmp, 1)

; Split the string from ";" , ";;" to " - "
Local $sFind = ";;"
Local $sReplace = " - "

Local $sFindTwo = ";"
Local $sReplaceTwo = " - "

; CSV tmp file find and replace
Local $iRetval = _ReplaceStringInFile($fileCsvTmp, $sFind, $sReplace)
Local $iRetval = _ReplaceStringInFile($fileCsvTmp, $sFindTwo, $sReplaceTwo)

;FileWriteLine($fileCsvTmp, "Result:" & @CRLF) ; CSV line 1 for filter
Local $iRetval = _ReplaceStringInFile($fileCsvTmp, $sFind, $sReplace)
_FileWriteToLine($fileCsvTmp, 1, "" , 1) ; Delete the first line from tmp file
MsgBox($MB_ICONINFORMATION, "Finish", "File is ready!" & @CRLF & @CRLF & FileRead($fileCsvTmp))