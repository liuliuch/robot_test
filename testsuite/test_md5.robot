*** Settings ***
Documentation    Suite description
Library   md5testLibrary.py
Library     python/RanTest.py

*** Test Cases ***
MD5_1_1
    set test variable    ${string}    123456
    ${md5_string}     md5_py    ${string}
    ${md5_string}    should be equal   12123
    log to console  ${md5_string}

生成MD5_2
    set test variable    ${string}     123456
    ${md5_string2}      生成MD5      ${string}
    log to console  ${md5_string2}

*** Keywords ***
