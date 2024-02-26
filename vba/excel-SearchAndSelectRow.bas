' made with chatgpt lol

Sub SelectRowsWithKeyword()
    Dim ws As Worksheet
    Dim searchRange As Range
    Dim keyword As String
    Dim cell As Range
    Dim selectedRows As Range

    ' Set the worksheet and range to search
    Set ws = ActiveSheet ' Change "Sheet1" to your sheet name
    Set searchRange = ws.Range("C1:C1000") ' Change the range as needed

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