#include <Excel.au3>
#include <MsgBoxConstants.au3>

Local $oExcel = _Excel_Open() ; Open excel
Local $sWorkbook = @ScriptDir & "\ExcelLoop.xls" ; File open
Local $oWorkbook = _Excel_BookOpen($oExcel, $sWorkbook)

$aCell = $oExcel.ActiveSheet.Cells($oExcel.Rows.Count, 1).End(-4162).Row ; -4162 = xlUp
$sCell = $aCell - 1 ; Sum of the cells for execution
; MsgBox(0,"Number of lines", sCell)

; $aColumn = $oExcel.ActiveSheet.Cells(10, $oExcel.Columns.Count).End(-4159).Column ; -4159 = xlToLeft
; MsgBox(0,"Number of columns", $aColumn)

$oExcel.Range("A2").Select            	; Select second line under the heading

; Script execution to empty line
While $sCell > 0
   Send("{DOWN}")
   Sleep(1000)
   $sCell = $sCell - 1
WEnd