Sub InsertarListaDeImagenes()
    Dim Pshp As Shape
    Dim xRg As Range
    Dim xCol As Long
    Dim cellfile As String
    Dim filepath As String
    Dim filenam As String
    
    Application.ScreenUpdating = False
    
    Set Rng = ActiveSheet.Range("A1:A1000")
    For Each cell In Rng
        cellfile = cell.Value
        filepath = Application.ActiveWorkbook.Path
        
        filenam = filepath & "\" & cellfile & ".jpg.jpg"
        
        On Error Resume Next
        Set Pshp = ActiveSheet.Shapes.AddPicture(filenam, False, True, 0, 0, -1, -1)
        On Error GoTo 0
        
        If Not Pshp Is Nothing Then
            xCol = cell.Column + 1
            Set xRg = Cells(cell.Row, xCol)
            
            With Pshp
                .ScaleHeight 1, True
                .ScaleWidth 1, True
                .Left = xRg.Left
                .Top = xRg.Top
                .LockAspectRatio = msoTrue
                .Height = xRg.RowHeight
                .Placement = xlMove
            End With
            
            With Pshp
                .Left = xRg.Left + ((xRg.Width - Pshp.Width) / 2)
                .Top = xRg.Top + ((xRg.Height - Pshp.Height) / 2)
            End With
        End If
        
        Set Pshp = Nothing
    Next cell
    
    Range("A1").Select
    Application.ScreenUpdating = True
End Sub
