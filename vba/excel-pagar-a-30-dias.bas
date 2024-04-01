Sub PagarA30Dias()
    Dim ws As Worksheet
    Dim searchRange As Range
    Dim keywords As Variant
    Dim keyword As Variant
    Dim cell As Range
    Dim selectedRows As Range
    Dim newRow As Range
    Dim thirtyDaysSheet As Worksheet
    Dim maxSheetNameLength As Integer
    Dim copyRange As Range
    Dim lastRow As Long
    Dim nextRow As Long
    Dim foundAny As Boolean
    
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
    
    ' Add a new sheet named "30dias" or use it if it already exists
    On Error Resume Next
    Set thirtyDaysSheet = ActiveWorkbook.Sheets("30dias")
    On Error GoTo 0
    
    If thirtyDaysSheet Is Nothing Then
        Set thirtyDaysSheet = ActiveWorkbook.Sheets.Add(After:=ActiveWorkbook.Sheets(ActiveWorkbook.Sheets.count))
        thirtyDaysSheet.Name = "30dias"
    End If
    
    ' Find the next available row in the "30dias" sheet
    nextRow = thirtyDaysSheet.Cells(thirtyDaysSheet.Rows.count, 1).End(xlUp).Row + 1
    
    ' Convertir la columna 6 a formato de fecha (yyyy-mm-dd)
    ConvertirTextoAFecha ws.Range(ws.Cells(searchRange.Row, 6), ws.Cells(searchRange.Row, 6).End(xlDown))
    
    ' Loop through each keyword in the array
    For Each keyword In keywords
        ' Clear previous selections
        searchRange.EntireRow.Interior.ColorIndex = xlNone
        foundAny = False
        
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
                
                foundAny = True
            End If
        Next cell

        ' Check if any rows were found
        If foundAny Then
            ' Check if the keyword length exceeds the maximum allowed length for sheet name
            If Len(keyword) > maxSheetNameLength Then
                MsgBox "The keyword length exceeds the maximum allowed length for sheet name. Truncating the name..."
                keyword = Left(keyword, maxSheetNameLength) ' Truncate the keyword
            End If

            ' Loop through each selected row
            For Each newRow In selectedRows.Rows
                ' Set the range to copy (columns 2, 6, and 11)
                Set copyRange = Union(ws.Cells(newRow.Row, 2), ws.Cells(newRow.Row, 6), ws.Cells(newRow.Row, 11))
                
                ' Copy the selected range to the "30dias" sheet
                copyRange.Copy Destination:=thirtyDaysSheet.Cells(nextRow, 1)
                
                ' Format column 11 as currency
                thirtyDaysSheet.Cells(nextRow, 3).NumberFormat = "$#,##0.00"
                
                ' Increment nextRow for the next set of copied rows
                nextRow = nextRow + 1
            Next newRow
        Else
            MsgBox "No matches found for keyword '" & keyword & "'."
        End If
        
        ' Clear selectedRows for next iteration
        Set selectedRows = Nothing
    Next keyword
    
    ' Autofit columns in the "30dias" sheet
    thirtyDaysSheet.Columns.AutoFit
    
    MsgBox "Columns 2, 6, and 11 for rows containing the specified keywords have been copied to the '30dias' sheet.", vbInformation
End Sub

Sub ConvertirTextoAFecha(rng As Range)
    Dim cell As Range
    
    ' Convertir texto a fecha y aplicar formato
    For Each cell In rng.Cells
        If IsDate(cell.Value) Then
            ' Convertir la celda a fecha y aplicar formato (yyyy-mm-dd)
            cell.Value = Format(CDate(cell.Value), "yyyy-mm-dd")
        End If
    Next cell
End Sub

