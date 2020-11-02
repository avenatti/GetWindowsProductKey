' Fetch current windows product key from the registry utilizing VB Script
'
' MIT License
'
' Copyright (c) 2018 Bernard Avenatti
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all
' copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
' SOFTWARE.

Set shell = CreateObject("WScript.Shell")

MsgBox ConvertToKey(shell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"))

Function ConvertToKey(Key)

Const offset = 52

i = 28
Chars = "BCDFGHJKMPQRTVWXY2346789"
Do
Cur = 0
x = 14
Do
Cur = Cur * 256
Cur = Key(x + offset) + Cur
Key(x + offset) = (Cur \ 24) And 255
Cur = Cur Mod 24

x = x - 1

Loop While x >= 0
i = i - 1
KeyOutput = Mid(Chars, Cur + 1, 1) & KeyOutput

If (((29 - i) Mod 6) = 0) And (i <> -1) Then
i = i - 1
KeyOutput = "-" & KeyOutput
End If

Loop While i >= 0
ConvertToKey = KeyOutput

End Function