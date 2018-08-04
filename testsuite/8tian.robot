*** Settings ***
Documentation    练习
Library    RequestsLibrary
Library    Collections
*** Test Cases ***
登陆
    Create Session    host    http://172.23.3.62:8091
    ${Token_get}    登陆用户端
    Set Suite Variable    ${Token_lod}    ${Token_get}

添加购物车
    添加购物车   ${Token_lod}
查看购物车


*** Keywords ***
登陆用户端
    [arguments]  ${email}   ${password}
    ${response}    Get Request    host    ${dologin}
    Should Be Equal As Strings    ${response.status_code}    200
    ${content}    to json    ${response.content}
    ${data}    Get From Dictionary     ${content}    data
    log    ${data}
    ${token}  Get From Dictionary    ${data}    token
    [return]    ${token}
添加购物车
    [Arguments]    ${token}
    ${response}    get Request    host    ${sync}${token}
    Should Be Equal As Strings    ${response.status_code}    200
    ${content}    to json    ${response.content}
    ${data}    Get From Dictionary     ${content}    data
    log    ${data}


*** Variables ***
${user_email}    liuchang@8dol.com
${password}      e10adc3949ba59abbe56e057f20f883e
${driver_no}    26ad0adf-bf26-421b-a670-f8ddab9f70f0
${dologin}      /v2/usercenter/doLogin?password=${password}&accountNo=${user_email}&deviceNo=${driver_no}
${sync_data}    [{"action":"PLUS_INCREMENT","button":{"enableClick":true,"type":"PLUS_MINUS_BUTTON"},"goodsId":266915,"labelId":0,"promotionId":0,"promotionType":"NORMAL","quantity":1}]
${sync}         /cart/sync?areaId=0&data=${sync_data}&app_version=AD_4.0.0&source=LIST&orgId=13&deviceNo=${driver_no}&token=