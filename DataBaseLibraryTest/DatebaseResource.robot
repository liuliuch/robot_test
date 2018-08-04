*** Settings ***
Documentation    修改密码
#Resource    ../testsuite/8tian.robot
Library     DatabaseLibrary
Library     RequestsLibrary
Library     Collections

*** Test Cases ***

重置密码
    发送验证码
    ${code}     查询验证码
    ${MD5}      获取MD5       ${reset_psw}
    ${response}    Get Request      host    ${reset_password}${MD5}&validationCode=${code[0][0]}&loginName=${user_email}
    should be equal as strings      ${response.status_code}     200
    ${content}     to json     ${response.content}
    ${data}     get from dictionary     ${content}      data
    should be equal as strings      ${data}      Password reset success
    登陆用户端   ${user_email}       ${reset_psw}

*** Keywords ***
连接数据库
    Connect To Database Using Custom Params  pymysql   ${english_line}
断开数据库连接
    Disconnect From Database

发送验证码
    create session   host    http://172.23.3.62:8091
    ${response}    Get Request      host    ${sent_email_road}${user_email}
    should be equal as strings  ${response.status_code}     200
    ${response_json}     to json       ${response.content}
    ${msg}      get from dictionary  ${response_json}   msg
    log    ${msg}
    Should Be Equal As Strings      ${msg}      success

查询验证码
    连接数据库
    ${code}    Query   SELECT `code` FROM t_msg_email where email ='${user_email}' AND email_type = 1 AND is_verified = '0' AND expire_time > now() ORDER BY create_time DESC LIMIT 1
    log     ${code}
    断开数据库连接
    [return]     ${code}
获取MD5
    [Arguments]  ${strings}
    ${MD5}    Evaluate      hashlib.md5('${strings}'.encode(encoding='utf8')).hexdigest()     hashlib
    [Return]    ${MD5}

登陆用户端
    [arguments]  ${email}   ${password}
    create session   host   http://172.23.3.62:8091
    ${password}     获取MD5     ${reset_psw}
    ${response}    Get Request    host    ${dologin}&accountNo=${email}&password=${password}
    Should Be Equal As Strings    ${response.status_code}    200
    ${content}    to json    ${response.content}
    ${data}    Get From Dictionary     ${content}    data
    log    ${data}
    ${token}  Get From Dictionary    ${data}    token
    [return]    ${token}
*** Variables ***
${english_line}     database='saledb', user='root', password='123456', host='172.23.3.65', port=3306
${user_email}       1291823196@qq.com
${sent_email_road}      /usercenter/sendEmail4ResetPassword?email=   #&deviceNo=8e510bea-b14e-3750-b5bc-f23679812d19&
${reset_password}       /usercenter/resetPassword?password=
${reset_psw}        12345678
${dologin}      /usercenter/doLogin?deviceNo=${driver_no}
${driver_no}    26ad0adf-bf26-421b-a670-f8ddab9f70f0