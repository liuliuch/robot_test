import hashlib
from robot.api.deco import keyword
class RanTest(object):
    '''
    关键字
    '''
    ROBOT_LIBRARY_SCOPE = 'Global'

    def __init__(self):
        pass

    def Add(self,*args):
        sum = 0
        for arg in args:
            sum += arg
        return sum

    @keyword('生成MD5')
    def md5(self,str):
        '''
        生成MD5
        :return:
        '''
        m = hashlib.md5()
        m.update(str.encode("utf8"))
        print(m.hexdigest())
        return m.hexdigest()

    @keyword('Multiply ${num1} by ${num2}')
    def Multiplication(self,num1,num2):
        return num1 * num2
