Attribute VB_Name = "Module1"
Public Function pchipend(h1 As Double, h2 As Double, del1 As Double, del2 As Double) As Double
    Dim d As Double
    
    d = ((2 * h1 + h2) * del1 - h1 * del2) / (h1 + h2)
    If (d * del1 < 0) Then
        d = 0
    ElseIf ((del1 * del2 < 0) And (Abs(d) > Abs(3 * del1))) Then
        d = 3 * del1
    End If
    
    pchipend = d
End Function

Public Function bdrint(rate As Range, dist As Range, low As Double, high As Double) As Double
    Dim log_rate(1 To 4) As Double
    Dim log_dist(1 To 4) As Double
    Dim i As Long
    For i = 1 To 4
        log_rate(i) = WorksheetFunction.Log(rate(5 - i), 10)
        log_dist(i) = dist(5 - i)
    Next i
    
    Dim H(1 To 3) As Double
    Dim delta(1 To 3) As Double
    
    For i = 1 To 3
        H(i) = log_dist(i + 1) - log_dist(i)
        delta(i) = (log_rate(i + 1) - log_rate(i)) / H(i)
    Next i
    
    Dim d(1 To 4) As Double
    
    d(1) = pchipend(H(1), H(2), delta(1), delta(2))
    
    For i = 2 To 3
        d(i) = (3 * H(i - 1) + 3 * H(i)) / ((2 * H(i) + H(i - 1)) / delta(i - 1) + (H(i) + 2 * H(i - 1)) / delta(i))
    Next i
    
    d(4) = pchipend(H(3), H(2), delta(3), delta(2))
    
    Dim c(1 To 3) As Double
    Dim b(1 To 3) As Double
    
    For i = 1 To 3
        c(i) = (3 * delta(i) - 2 * d(i) - d(i + 1)) / H(i)
        b(i) = (d(i) - 2 * delta(i) + d(i + 1)) / (H(i) * H(i))
    Next i

    ' cubic function is rate(i) + s*(d(i) + s*(c(i) + s*(b(i))) where s = x - dist(i)
    ' or rate(i) + s*d(i) + s*s*c(i) + s*s*s*b(i)
    ' primitive is s*rate(i) + s*s*d(i)/2 + s*s*s*c(i)/3 + s*s*s*s*b(i)/4
    
    Dim s0 As Double
    Dim s1 As Double
    Dim result As Double
    
    result = 0
    
    For i = 1 To 3
        s0 = log_dist(i)
        s1 = log_dist(i + 1)
        
        ' clip s0 to valid range
        s0 = WorksheetFunction.Max(s0, low)
        s0 = WorksheetFunction.Min(s0, high)
        
        ' clip s1 to valid range
        s1 = WorksheetFunction.Max(s1, low)
        s1 = WorksheetFunction.Min(s1, high)
                
        s0 = s0 - log_dist(i)
        s1 = s1 - log_dist(i)
        
        If (s1 > s0) Then
            result = result + (s1 - s0) * log_rate(i)
            result = result + (s1 * s1 - s0 * s0) * d(i) / 2
            result = result + (s1 * s1 * s1 - s0 * s0 * s0) * c(i) / 3
            result = result + (s1 * s1 * s1 * s1 - s0 * s0 * s0 * s0) * b(i) / 4
        End If
    Next i
    
    bdrint = result
End Function

Public Function bdrate(rateA As Range, distA As Range, rateB As Range, distB As Range) As Double
    Dim minPSNR As Double
    Dim maxPSNR As Double
    
    minPSNR = WorksheetFunction.Max(WorksheetFunction.Min(distA), WorksheetFunction.Min(distB))
    maxPSNR = WorksheetFunction.Min(WorksheetFunction.Max(distA), WorksheetFunction.Max(distB))
    
    Dim vA As Double
    Dim vB As Double
    
    vA = bdrint(rateA, distA, minPSNR, maxPSNR)
    vB = bdrint(rateB, distB, minPSNR, maxPSNR)
    
    Dim avg As Double
    avg = (vB - vA) / (maxPSNR - minPSNR)
    
    bdrate = WorksheetFunction.Power(10, avg) - 1
End Function

Public Function bdrintOld(rate As Range, dist As Range, low As Double, high As Double) As Double
    Dim log_rate(1 To 4) As Double
    Dim log_dist(1 To 4) As Double
    Dim i As Long
    For i = 1 To 4
        log_rate(i) = WorksheetFunction.Log(rate(5 - i), 10)
        log_dist(i) = dist(5 - i)
    Next i
    
    Dim E(4), F(4), G(4), H(4) As Double
    Dim DET0, DET1, DET2, DET3, DET As Double
    Dim D0, D1, D2, D3 As Double
    Dim p(4) As Double
    
    ' Code below copy-pasted from previously provided template BJM.xla - Copyright (C) 2007 by Orange - France Telecom R&D
    ' Contacts:
    '   - St_phane Pateux, +(33)299124177, stephane.pateux@orange-ftgroup.com
    '   - Joel Jung, +(33)145295366, joelb.jung@orange-ftgroup.com

    For i = 0 To 3
        E(i) = log_dist(i + 1)
        F(i) = E(i) * E(i)
        G(i) = E(i) * E(i) * E(i)
        H(i) = log_rate(i + 1)
    Next i
    
    DET0 = E(1) * (F(2) * G(3) - F(3) * G(2)) - E(2) * (F(1) * G(3) - F(3) * G(1)) + E(3) * (F(1) * G(2) - F(2) * G(1))
    DET1 = -E(0) * (F(2) * G(3) - F(3) * G(2)) + E(2) * (F(0) * G(3) - F(3) * G(0)) - E(3) * (F(0) * G(2) - F(2) * G(0))
    DET2 = E(0) * (F(1) * G(3) - F(3) * G(1)) - E(1) * (F(0) * G(3) - F(3) * G(0)) + E(3) * (F(0) * G(1) - F(1) * G(0))
    DET3 = -E(0) * (F(1) * G(2) - F(2) * G(1)) + E(1) * (F(0) * G(2) - F(2) * G(0)) - E(2) * (F(0) * G(1) - F(1) * G(0))
    DET = DET0 + DET1 + DET2 + DET3

    D0 = H(0) * DET0 + H(1) * DET1 + H(2) * DET2 + H(3) * DET3

    D1 = H(1) * (F(2) * G(3) - F(3) * G(2)) - H(2) * (F(1) * G(3) - F(3) * G(1)) + H(3) * (F(1) * G(2) - F(2) * G(1))
    D1 = D1 - H(0) * (F(2) * G(3) - F(3) * G(2)) + H(2) * (F(0) * G(3) - F(3) * G(0)) - H(3) * (F(0) * G(2) - F(2) * G(0))
    D1 = D1 + H(0) * (F(1) * G(3) - F(3) * G(1)) - H(1) * (F(0) * G(3) - F(3) * G(0)) + H(3) * (F(0) * G(1) - F(1) * G(0))
    D1 = D1 - H(0) * (F(1) * G(2) - F(2) * G(1)) + H(1) * (F(0) * G(2) - F(2) * G(0)) - H(2) * (F(0) * G(1) - F(1) * G(0))

    D2 = E(1) * (H(2) * G(3) - H(3) * G(2)) - E(2) * (H(1) * G(3) - H(3) * G(1)) + E(3) * (H(1) * G(2) - H(2) * G(1))
    D2 = D2 - E(0) * (H(2) * G(3) - H(3) * G(2)) + E(2) * (H(0) * G(3) - H(3) * G(0)) - E(3) * (H(0) * G(2) - H(2) * G(0))
    D2 = D2 + E(0) * (H(1) * G(3) - H(3) * G(1)) - E(1) * (H(0) * G(3) - H(3) * G(0)) + E(3) * (H(0) * G(1) - H(1) * G(0))
    D2 = D2 - E(0) * (H(1) * G(2) - H(2) * G(1)) + E(1) * (H(0) * G(2) - H(2) * G(0)) - E(2) * (H(0) * G(1) - H(1) * G(0))

    D3 = E(1) * (F(2) * H(3) - F(3) * H(2)) - E(2) * (F(1) * H(3) - F(3) * H(1)) + E(3) * (F(1) * H(2) - F(2) * H(1))
    D3 = D3 - E(0) * (F(2) * H(3) - F(3) * H(2)) + E(2) * (F(0) * H(3) - F(3) * H(0)) - E(3) * (F(0) * H(2) - F(2) * H(0))
    D3 = D3 + E(0) * (F(1) * H(3) - F(3) * H(1)) - E(1) * (F(0) * H(3) - F(3) * H(0)) + E(3) * (F(0) * H(1) - F(1) * H(0))
    D3 = D3 - E(0) * (F(1) * H(2) - F(2) * H(1)) + E(1) * (F(0) * H(2) - F(2) * H(0)) - E(2) * (F(0) * H(1) - F(1) * H(0))

    p(0) = D0 / DET
    p(1) = D1 / DET
    p(2) = D2 / DET
    p(3) = D3 / DET
    
    ' End of copy-pasted code
    
    Dim result As Double
    result = 0
    
    result = result + p(0) * high
    result = result + p(1) * high * high / 2
    result = result + p(2) * high * high * high / 3
    result = result + p(3) * high * high * high * high / 4
    result = result - p(0) * low
    result = result - p(1) * low * low / 2
    result = result - p(2) * low * low * low / 3
    result = result - p(3) * low * low * low * low / 4
    
    bdrintOld = result
End Function

Public Function bdrateOld(rateA As Range, distA As Range, rateB As Range, distB As Range) As Double
    Dim minPSNR As Double
    Dim maxPSNR As Double
    
    minPSNR = WorksheetFunction.Max(WorksheetFunction.Min(distA), WorksheetFunction.Min(distB))
    maxPSNR = WorksheetFunction.Min(WorksheetFunction.Max(distA), WorksheetFunction.Max(distB))
    
    Dim vA As Double
    Dim vB As Double
    
    vA = bdrintOld(rateA, distA, minPSNR, maxPSNR)
    vB = bdrintOld(rateB, distB, minPSNR, maxPSNR)
    
    Dim avg As Double
    avg = (vB - vA) / (maxPSNR - minPSNR)
    
    bdrateOld = WorksheetFunction.Power(10, avg) - 1
End Function


