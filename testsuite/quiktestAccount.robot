*** Settings ***
Documentation    Suite description
Library  DatabaseLibrary

*** Test Cases ***
初始化账号
    连接数据库
    执行sql语句     UPDATE t_user set mobile = '13270813896',password ='e10adc3949ba59abbe56e057f20f883e' where account_id = '2757'
    执行sql语句     UPDATE t_Account set balance = '1000' where id ='2757'
    断开数据库连接


*** Keywords ***
连接数据库
    Connect To Database Using Custom Params  pymysql   ${390_line}
断开数据库连接
    Disconnect From Database
执行sql语句
    [Arguments]  ${sql}
    Execute Sql String  ${sql}
*** Variables ***
${390_line}     database='coredb', user='8dol', password='8dol', host='172.23.3.85', port=3306