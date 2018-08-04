# # t=('z'-'a')%26+'a'
# # print(t)
# print(ord('e'))
# print(chr(65))
#
# # t=('z'-'a')%26+'a'
# # print(t)
# print(ord('e'))
# print(chr(65))
#
# # t=('z'-'a')%26+'a'
# # print(t)
# print(ord('e'))
# print(chr(65))
#
class Solution:
    def shiftingLetters(self, S, shifts):
        """
        :type S: str
        :type shifts: List[int]
        :rtype: str
        """
        self.S=S
        self.shifts =shifts
        for i in range (len(shifts)- 1, -1, -1):
             for j in range (0, i+1):
                 char = chr((ord(S[j]) - ord('a') + shifts[i]) % 26+ord('a'))
                 # print(char)
                 S = S[:j]+char+S[j+1:]   #字符串不能被直接修改
                 # print(S)
        return S

s="abc"
c=[3,5,9]
A = Solution(s,c)
