' Place decrypted content on word
' Insert -> Quick Parts -> Auto Text -> Save Selection. Give it a name and save
' Replace the content with the encrypted message

Sub AutoOpen()
    subText
End Sub
Sub Document_Open()
    subText
End Sub
Sub subText()
    ActiveDocument.Content.Select
    Selection.Delete
    ActiveDocument.AttachedTemplate.AutoTextEntries("<template_name>").Insert Where:=Selection.Range, RichText:=True
End Sub
