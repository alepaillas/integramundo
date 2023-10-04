Sub InsertarListaDeImagenes()
'Updateby Extendoffice 20161116
'Update by Haytham Amairah 20180104
'Update by Alejandra Paillas 20210425

    Dim Pshp As Shape
    Dim xRg As Range
    Dim xCol As Long
        
    On Error Resume Next
    Application.ScreenUpdating = False
    
    Set Rng = ActiveSheet.Range("A1:A140")
    For Each cell In Rng
        cellfile = cell
        filepath = Application.ActiveWorkbook.Path
        
        'MsgBox "Current directory is " & filepath
        
        filenam = (filepath & "\" & cellfile & ".jpg")
        
        'MsgBox "Current directory is " & filenam
        
        ActiveSheet.Pictures.Insert(filenam).Select
        
        Set Pshp = Selection.ShapeRange.Item(1)
        
        Pshp.Placement = xlMoveAndSize
        
        If Pshp Is Nothing Then GoTo lab
        
        xCol = cell.Column + 1
        Set xRg = Cells(cell.Row, xCol)
        
        'With Pshp
        '    .LockAspectRatio = msoTrue
        '    .Width = 60
        '    .Height = 30
        '    .Top = xRg.Top + (xRg.Height - .Height) / 2
        '    .Left = xRg.Left + (xRg.Width - .Width) / 2
        'End With
        
        With Pshp
            .ScaleHeight 1, True
            .ScaleWidth 1, True
            .Left = xRg.Left
            .Top = xRg.Top
            .LockAspectRatio = msoTrue
            .Height = xRg.RowHeight
            '.Width = xRg.ColumnWidth
            
            '.Height = xRg.Height
            '.Width = xRg.Width
            .Placement = xlMove
        End With
        
        With Pshp
            .Left = xRg.Left + ((xRg.Width - Pshp.Width) / 2)
            .Top = xRg.Top + ((xRg.Height - Pshp.Height) / 2)
        End With
        
        
lab:
    Set Pshp = Nothing
    Range("A1").Select
    Next
    Application.ScreenUpdating = True
    
End Sub

