Attribute VB_Name = "InvertSelection"
Sub InvertSelection()
'Updateby20140314
Dim Rng As Range
Dim Rng1 As Range
Dim Rng2 As Range
Dim OutRng As Range
xTitleId = "KutoolsforExcel"
Set Rng1 = Application.Selection
Set Rng1 = Application.InputBox("Range1 :", xTitleId, Rng1.Address, Type:=8)
Set Rng2 = Application.InputBox("Range2", xTitleId, Type:=8)
For Each Rng In Rng2
    If Application.Intersect(Rng, Rng1) Is Nothing Then
        If OutRng Is Nothing Then
            Set OutRng = Rng
        Else
            Set OutRng = Application.Union(OutRng, Rng)
        End If
    End If
Next
OutRng.Select
End Sub
