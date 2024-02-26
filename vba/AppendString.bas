Attribute VB_Name = "AppendString"
Sub AppendStringToEndOfRangeWithInput()
    Dim rng As Range
    Dim cell As Range
    Dim AppendString As String
    
    ' Prompt user to select a range
    On Error Resume Next
    Set rng = Application.InputBox("Select a range", Type:=8)
    On Error GoTo 0
    
    If rng Is Nothing Then
        MsgBox "No range selected. Macro will exit.", vbExclamation
        Exit Sub
    End If
    
    ' Prompt user to enter the string to append
    AppendString = InputBox("Enter the string you want to append:", "Append String")
    
    ' Check if the user canceled the input box
    If AppendString = "" Then
        MsgBox "No string entered. Macro will exit.", vbExclamation
        Exit Sub
    End If
    
    ' Loop through each cell in the selected range
    For Each cell In rng
        If Not IsEmpty(cell.Value) Then
            cell.Value = cell.Value & AppendString
        End If
    Next cell
    
    MsgBox "String appended successfully to the selected range.", vbInformation
End Sub

