Attribute VB_Name = "SelectRowsWithKeyword"
Sub SelectRowsWithKeyword()
    Dim ws As Worksheet
    Dim searchRange As Range
    Dim keyword As String
    Dim cell As Range
    Dim selectedRows As Range

    ' Set the worksheet
    Set ws = ActiveSheet ' Change to the desired worksheet if needed

    ' Prompt user to select the range to search within
    On Error Resume Next
    Set searchRange = Application.InputBox("Select the range to search within", Type:=8)
    On Error GoTo 0
    
    ' Check if user canceled or didn't select a valid range
    If searchRange Is Nothing Then
        MsgBox "No range selected. Operation canceled."
        Exit Sub
    End If

    ' Prompt user for the keyword to search
    keyword = InputBox("Enter the keyword to search for:", "Keyword Search")

    ' Check if the keyword is entered
    If keyword <> "" Then
        ' Clear previous selections
        searchRange.EntireRow.Interior.ColorIndex = xlNone

        ' Loop through each cell in the search range
        For Each cell In searchRange
            ' Check if the cell contains the keyword
            If InStr(1, cell.Value, keyword, vbTextCompare) > 0 Then
                ' Store the row in the selectedRows range
                If selectedRows Is Nothing Then
                    Set selectedRows = cell.EntireRow
                Else
                    Set selectedRows = Union(selectedRows, cell.EntireRow)
                End If
            End If
        Next cell

        ' Check if any rows were found
        If Not selectedRows Is Nothing Then
            ' Select the entire range of matched rows
            selectedRows.Select
        Else
            MsgBox "No matches found."
        End If
    Else
        MsgBox "No keyword entered. Macro canceled."
    End If
End Sub

