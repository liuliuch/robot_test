*** Settings ***
Library     RanTest
Library   md5testLibrary.py

*** Test Cases ***

生成MD5
    ${md5}      生成MD5     liuchamg
    log      ${md5}
A*B
    ${C}    Multiply ${3} by ${4}
    log  ${C}

MD5_1_3
    set test variable    ${string}    'liuchang'
    ${md5_string}     md5_py    ${string}
    





#A+B
#    ${A}        set variable     3
#    ${B}        set variable     4
#    ${sum}      add    ${3}    ${4}     ${5}
#
#    should be equal as numbers      ${sum}   12
*** Keywords ***
