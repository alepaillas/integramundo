Sub ExportarImagenes()
  Dim img As Shape, tempChart As ChartObject
  Dim sPath As String, sName As String
    
  sPath = Application.ActiveWorkbook.Path
  
  For Each img In ActiveSheet.Shapes
    If img.TopLeftCell.Column = 2 Then
      sName = img.TopLeftCell.Offset(0, -1).Value
      If sName <> "" Then
        img.CopyPicture xlScreen, xlPicture
        Set tempChart = ActiveSheet.ChartObjects.Add(0, 0, img.Width, img.Height)
        With tempChart
          .Activate
          .Border.LineStyle = xlLineStyleNone
          .Chart.Paste
          .Chart.Export sPath & "\" & sName & ".jpg"
          .Delete
        End With
      End If
    End If
  Next
End Sub
