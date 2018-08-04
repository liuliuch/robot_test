*** Settings ***
Documentation    Suite description
Library  RequestsLibrary
Library  Collections


*** Test Cases ***
登录
    ${rnd}    获取随机值
    Create Session    api    https://m.shanghehui.com
    ${response}   Post request    api    /api/v3/member/login?appKey=498CZZDC&CheckSession=false&rnd=${rnd}       ${form_data}
    Should Be Equal As Strings    ${response.status_code}    200
#    ${data}    Set Variables


*** Keywords ***
获取随机值
    ${random}    Evaluate    random.randint(0, 1000)    modules=random, sys
    [Return]    ${random}

*** Variables ***
${form_data}    {"deviceId":"MOBCBYW4635CF112E8M6","loginType":"password","name":"15506290821","nameType":"phone","password":"2539749cc8b986f8eb05896cf9b33562012cc489850072bb7a0945265266612d","source":"portal_web","usermark":"MOBCBYW4635CF112E8M6"}