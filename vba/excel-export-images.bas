Sub ExportarTodasLasImagenes()
    Dim sPath As String, sName As String
        
    Dim iPicWidth As Integer
    Dim iPicHeight As Integer
    Dim pic As Shape
    Dim sPicName As String
    Dim iPicRow As Integer
    
    Application.ScreenUpdating = False  'Turn off screen updates to make this macro run faster
        
    On Error Resume Next
    
    sPath = Application.ActiveWorkbook.Path
    
    MkDir sPath & "\Imagenes"   'Create a folder
        
    For Each pic In ActiveSheet.Shapes  'Loop through each shape in the active worksheet.
    
        If pic.Type = msoAutoShape Or pic.Type = msoPicture Then    'shape type: AutoShape or Picture
            
            iPicRow = pic.TopLeftCell.Row  'Picture row
            ''Please make sure the picture name is legal
            sPicName = ActiveSheet.Cells(iPicRow, 2) 'Picture name, 2 means in column B
            
            If sPicName <> "" Then 'Check if the picture name exists
                
                iPicWidth = pic.Width   'original picture width
                iPicHeight = pic.Height 'original picture height
                    
                ''You can set the exported image size according to your needs
                pic.LockAspectRatio = msoTrue  'Lock Aspect Ratio
                pic.ScaleHeight 1.5, msoFalse, msoScaleFromTopLeft  'Exported image size. Scale 150%.
                    
                ''Or you can specify the exported image size
                'pic.Width = 400  'Set width 400px
                'pic.Height = 400 'Set height 400px
                
                pic.Copy    'Copy to clipboard
                
                With ActiveSheet.ChartObjects.Add(0, 0, pic.Width, pic.Height).Chart 'Create a embedded chart
                    .Parent.Select  'Select chart
                    .Paste  'Paste
                    .Export sPath & "\Imagenes\" & sPicName & ".jpg"    'Export picture
                    .Parent.Delete  'Delete chart
                End With
                    
                pic.Width = iPicWidth 'Rest picture to default size
                pic.Height = iPicHeight 'Rest picture to default size
                
            End If
        End If
        
    Next
        
    MsgBox "Todas las imagenes se exportaron a la carpeta Imagenes creada junto al archivo actual."
        
    Application.ScreenUpdating = True
End Sub

