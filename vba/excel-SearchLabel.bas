Attribute VB_Name = "SearchLabel"
Sub SearchLabel()
    Dim FindString As String
    FindString = InputBox("Ingrese etiqueta a buscar")
    
    Dim papelString As String
    papelString = InputBox("Ingrese tipo de papel a buscar:")
    
    Dim cantidadInt As Integer
    cantidadInt = InputBox("Ingrese cantidad de etiquetas por rollo a buscar:")
    
    Dim coste As Double
    coste = InputBox("Ingrese coste:")
    
    Dim precio As Double
    precio = InputBox("Ingrese precio de venta")
    
    Dim Rng As Range
    Set Rng = Range("D1:D7000")
    
    Dim findRng As Range
    Set findRng = Rng.Find(What:=FindString, LookAt:=xlPart)
    
    Dim firstCell As String
    firstCell = findRng.Address
    
    Do
        Application.Goto findRng, True
        
        If InStr(1, findRng.Offset(0, 4), cantidadInt) > 0 And InStr(1, findRng.Offset(0, 4), papelString) > 0 Then
            'True
            response = MsgBox("¿Editar Coste y Precio?", vbYesNo)
            If response = vbNo Then
                'MsgBox "Bye."
                GoTo siguiente
            End If
        
            findRng.Offset(0, -2).Interior.ColorIndex = 4 'Green
            findRng.Offset(0, -2).Value = coste
            findRng.Offset(0, 1).Interior.ColorIndex = 4 'Green
            findRng.Offset(0, 1).Value = precio
        Else
            'False
        End If
        
siguiente:
        Set findRng = Rng.FindNext(findRng)
    Loop While firstCell <> findRng.Address
End Sub
