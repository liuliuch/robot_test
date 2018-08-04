while True:
    try:
        str1 = input("请输入第一个整数")
        if str1 == 'q':
            quit()
        else:
            num1 = int(str1)
    except ValueError:

        print('你输入的不是整数')

    try:
        str2 = input("请输入第二个整数")
        if str2 == 'q':
            quit()
        else:
            num2 = int(str2)
    except ValueError:
        print('你输入的不是整数')
    print(num1,num2)
    print('%d+%d=%d'%(num1,num2,num1+num2))
    quit()
