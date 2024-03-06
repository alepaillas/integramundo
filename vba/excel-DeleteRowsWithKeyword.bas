Attribute VB_Name = "DeleteRowsWithKeyword"
Sub DeleteRowsWithKeyword()
    Dim ws As Worksheet
    Dim searchRange As Range
    Dim keyword As String
    Dim cell As Range
    Dim rowsToDelete As Collection
    Dim i As Long
    Dim deletedCount As Long

    ' Set the worksheet
    Set ws = ActiveSheet ' Cambia a la hoja de cálculo deseada si es necesario

    ' Prompt user to select the range to search within
    On Error Resume Next
    Set searchRange = Application.InputBox("Selecciona el rango para buscar", Type:=8)
    On Error GoTo 0
    
    ' Check if user canceled or didn't select a valid range
    If searchRange Is Nothing Then
        MsgBox "No se ha seleccionado ningún rango. Operación cancelada."
        Exit Sub
    End If

    ' Prompt user for the keyword to search
    keyword = InputBox("Ingresa la palabra clave a buscar:", "Búsqueda de palabra clave")

    ' Check if the keyword is entered
    If keyword <> "" Then
        ' Initialize collection to store rows to delete
        Set rowsToDelete = New Collection

        ' Loop through each cell in the search range
        For Each cell In searchRange
            ' Check if the cell contains the keyword
            If InStr(1, cell.Value, keyword, vbTextCompare) > 0 Then
                ' Store the row to delete
                rowsToDelete.Add cell.Row
            End If
        Next cell

        ' Check if any rows were found
        If rowsToDelete.count > 0 Then
            ' Loop through rows to delete from bottom to top to avoid issues with shifting
            For i = rowsToDelete.count To 1 Step -1
                ws.Rows(rowsToDelete(i)).Delete
            Next i
            deletedCount = rowsToDelete.count
            MsgBox deletedCount & " filas eliminadas."
        Else
            MsgBox "No se encontraron coincidencias."
        End If
    Else
        MsgBox "No se ha ingresado ninguna palabra clave. Macro cancelada."
    End If
End Sub

