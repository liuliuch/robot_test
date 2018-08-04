#!/usr/bin/env python
#-*-coding:utf-8-*-

def func(x):
    return x+1

def test_answer():     #测试用例必以test_开头
    assert  func(3) == 4



# 潜规则
# 在批量执行用例之前，我们需要了解一下pytest的潜规则，注意，由于pytest可以支持丰富的定制选项，
# 下面的潜规则是在没有定制的默认情况下的缺省规则
#
#       pytest会找当前以及递查找子文件夹下面所有的test_*.py或*_test.py的文件，把其当作测试文件
#       在这些文件里，pytest会收集下面的一些函数或方法，当作测试用例
#       不在类定义中的以test_开头的函数或方法
#       在以Test开头的类中(不能包含__init__方法)，以test_开头的方法
#       pytest也支持unittest模式的用例定义