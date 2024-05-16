Sub SelectRowsWithHardcodedKeywordsAndCopyToNewSheets()
    Dim ws As Worksheet
    Dim searchRange As Range
    Dim keywords As Variant
    Dim keyword As Variant
    Dim cell As Range
    Dim selectedRows As Range
    Dim newRow As Range
    Dim nuevaHoja As Worksheet
    Dim maxSheetNameLength As Integer
    Dim copyRange As Range
    Dim lastRow As Long
    
    ' Set the maximum allowed length for sheet name
    maxSheetNameLength = 31 ' This is the maximum allowed length for sheet name in Excel
    
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

    ' Define the array of keywords to search
    keywords = Array("Comercial INK Paper Ltda", "IMPORTACIONES Y DISTRIBUCION ADIOFFICE LIMITADA", "SOLPACK S.A.", "IMPORTADORA Y COMERCIALIZADORA HASSI SPA", "ENVASES PLACART S.A") ' Add more keywords as needed
    
    ' Loop through each keyword in the array
    For Each keyword In keywords
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
            ' Check if the keyword length exceeds the maximum allowed length for sheet name
            If Len(keyword) > maxSheetNameLength Then
                MsgBox "The keyword length exceeds the maximum allowed length for sheet name. Truncating the name..."
                keyword = Left(keyword, maxSheetNameLength) ' Truncate the keyword
            End If
            
            ' Add a new sheet with the keyword name
            Set nuevaHoja = ActiveWorkbook.Sheets.Add(After:=ActiveWorkbook.Sheets(ActiveWorkbook.Sheets.count))
            nuevaHoja.Name = keyword
            
            ' Determine the last row in the selected range
            lastRow = selectedRows.Rows.count

            ' Set the range to copy (columns 6 and 11)
            Dim col6 As Range
            Dim col11 As Range
            Set col6 = ws.Range(ws.Cells(selectedRows.Row, 6), ws.Cells(selectedRows.Row + lastRow - 1, 6))
            Set col11 = ws.Range(ws.Cells(selectedRows.Row, 11), ws.Cells(selectedRows.Row + lastRow - 1, 11))
            Set copyRange = Union(col6, col11)

            ' Copy the selected range to the new sheet
            copyRange.Copy Destination:=nuevaHoja.Cells(1, 1)

            ' Autofit columns in the new sheet
            nuevaHoja.Columns.AutoFit
            
            MsgBox "Columns 6 and 11 for rows containing '" & keyword & "' have been copied to the new sheet '" & keyword & "'.", vbInformation
        Else
            MsgBox "No matches found for keyword '" & keyword & "'."
        End If
        
        ' Clear selectedRows for next iteration
        Set selectedRows = Nothing
    Next keyword
End Sub

