file_path = './testtxt/pi.txt'
print('*1'+'-'*20)
with open(file_path) as file_opject:
    print('  *1.1' + '-' * 20)
    content = file_opject.read()
    print(content)
    print('  *1.2'+'-' * 20)
    print(content.rstrip())  # rstrip()是去除字符串末尾的空白

print('*2'+'-'*20)
with open(file_path) as file_opject:
    for line in file_opject:
        print(line.rstrip())   #去除print之后增加的空行
'''
使用关键字with 时， open() 返回的文件对象只在with 代码块内可用。
如果要在with 代码块外访问文件的内容， 可在with 代码块内将文件的各行存储在一个列表中，
并在with 代码块外使用该列表： 你可以立即处理文件的各个部分， 也可推迟到程序后面再处理
'''
print('*3'+'-'*20)
with open(file_path) as file_opject:
    lines = file_opject.readlines()        #将读取的内容存储为一个列表
print('  *3.1'+'-'*20)
for line in lines:
    print(line.rstrip())

print('  *3.2'+'-'*20)
pi_string = ''
for line in lines:
    pi_string +=line.strip()    #此处使用strip() 而不是人strip()，去除来位于每行的空格
print(pi_string)
print('pi的长度是%d' % len(pi_string))          #格式化输出

'''
读取文本文件时， Python将其中的所有文本都解读为字符串。
如果你读取的是数字， 并要将其作为数值使用， 就必须使用函数int() 将其转换为整数，
或使用函数float() 将其转换为浮点数
'''
