Option Explicit

Sub InsertarImagenesDeCarpeta()

    Dim strFolder As String
    Dim strFileName As String
    Dim strFilePath As String
    Dim objPic As Shape
    Dim rngCell As Range
    Dim i As Integer
    Dim MyCurrentDir As String
    
    MyCurrentDir = Application.ActiveWorkbook.Path
        
    'MsgBox "Current Directory is " & MyCurrentDir
    
    strFolder = (MyCurrentDir) 'change the path accordingly ex: "D:\pictures"
    If Right(strFolder, 1) <> "\" Then
        strFolder = strFolder & "\"
    End If

    Set rngCell = Range("A1") 'starting cell

    strFileName = Dir(strFolder & "*.jpg", vbNormal) 'filter for .jpg files

    'strFilePath = (strFolder & strFileName)

    i = 1

    Do While Len(strFileName) > 0
        Set objPic = Application.ActiveSheet.Shapes.AddPicture(strFolder & strFileName, False, True, 1, 1, 1, 1)
        With objPic
            .ScaleHeight 1, True
            .ScaleWidth 1, True
            .Left = rngCell.Left
            .Top = rngCell.Top
            .LockAspectRatio = msoTrue
            .Height = rngCell.RowHeight
            '.Width = rngCell.ColumnWidth
            
            '.Height = rngCell.Height
            '.Width = rngCell.Width
            .Placement = xlMove
        End With
        
        With objPic
            .Left = rngCell.Left + ((rngCell.Width - objPic.Width) / 2)
            .Top = rngCell.Top + ((rngCell.Height - objPic.Height) / 2)
        End With
        
        ActiveSheet.Cells(i, 2) = (strFileName)
        i = i + 1
        Set rngCell = rngCell.Offset(1, 0)
        strFileName = Dir
    Loop

End Sub


