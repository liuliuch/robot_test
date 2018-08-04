def shiftingLetters(S, shifts):
    """
    :type S: str
    :type shifts: List[int]
    :rtype: str
    """
    # new = S

    for i in range (len(shifts)- 1, -1, -1):
        for j in range (0, i+1):
            char = chr((ord(S[j]) - ord('a') + shifts[i]) % 26+ord('a'))
            print(char)
            S = S[:j]+char+S[j+1:]

            print(S)
    return S
a="aaa"
s=[1,2,3]
shiftingLetters(a,s)



