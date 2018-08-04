*** Settings ***
Documentation    Suite description
Suite Setup         连接服务开启
Suite Teardown      断开连接服务
Resource            ../Keyword/初始化环境.txt
Resource            ../Resource/接口路径.txt
Resource            ../Keyword/常用流程.txt
Library             BuiltIn
Library             Collections
Library             RequestsLibrary

*** Test Cases ***


登陆
    ${addr}     用户登录     ${S_username}    ${S_password}
    should be equal as strings   ${addr.status_code}    200
    log to console      ${addr.status_code}
    ${response}     To json     ${addr.content}
    log to console      ${response}
    ${msg}      get from dictionary      ${response}       msg
    log to console      ${msg}
    should be equal as strings   ${msg}     success


添加地址并查看地址列表
    ${token}    获取登陆Token
    set test variable       ${address_nick}    house
    ${addr}     get request     api     ${P_添加地址}${token}&addressNickname=${address_nick}
    should be equal as strings      ${addr.status_code}     200
    ${response}    to json     ${addr.content}
    ${data}      get from dictionary     ${response}      data
    log to console  ${data}
    ${address_nick_name}  get from dictionary   ${data}     addressNickname
    should be equal    ${address_nick_name}    ${address_nick}
    ${address_id}       get from dictionary     ${data}     id
    ${addr}     get request     api     /user/queryAddress?${commen_headers}&token=${token}
    ${response}     to json     ${addr.content}
    ${data}     get from dictionary     ${response}     data
    ${tuple}    字典转换成元祖         ${data}
    ${id}       get from dictionary      ${tuple[0]}     id
    should be equal    ${id}    ${address_id}

下单特价商品
    ${token}    获取登陆Token
    清空购物车   ${token}
    添加购物车查看购物车列表    ${token}    ${S_HSPgoods_id}
    ${cardToken}    ${addressId}    从购物车去结算   ${token}
    ${payToken}     获取支付token        ${token}
    ${addr}     支付订单     ${S_HSPgoods_id}   ${payToken}   ${address_id}   ${cardToken}    ${token}   HSP   24767
    should be equal as strings   ${addr.status_code}    200
    ${response}     To Json     ${addr.content}
    log to console      ${response}
    ${支付_msg}       get from dictionary     ${response}     msg
    should be equal as strings      ${支付_msg}       success



*** Keywords ***
获取登陆Token
    ${addr}     用户登录     ${S_username}    ${S_password}
    ${response}     To Json     ${addr.content}
    ${data}     get from dictionary     ${response}     data
    ${token}    get from dictionary     ${data}     token
#    log to console      ${token}
    [Return]    ${token}

添加购物车查看购物车列表
    [Arguments]  ${token}      ${t_goods_id}
    ${addr}     get request     api     ${P_添加购物车}&token=${token}&source=${S_source}&data=${basket_data}
    should be equal as strings  ${addr.status_code}     200
    ${response}     To Json     ${addr.content}
    ${data}     get from dictionary     ${response}     data
#    log to console  ${data['cartList']}
    ${goods_id}     get from dictionary  ${data['cartList'][0]}    goodsId
    log to console      ${goods_id}
    should be equal as strings  ${t_goods_id}  ${goods_id}

从购物车去结算
    [Arguments]  ${token}
    ${addr}     get request     api     ${P_去结算}${checkout_data}&token=${token}
    should be equal as strings    ${addr.status_code}    200
    ${response}     To Json  ${addr.content}
    ${msg}   get from dictionary  ${response}   msg
    should be equal as strings    ${msg}       success
    ${data}     get from dictionary   ${response}   data
#    log to console  ${data}
    ${CardToken}    get from dictionary      ${data['cardList'][0]}      cardId
    log to console   cardid:${CardToken}
    ${addressId}    get from dictionary      ${data['userAddressList'][0]}   id
    log to console   addressid:${addressId}
    [Return]  ${CardToken}  ${addressId}


获取支付token
    [Arguments]  ${token}
    ${addr}    get request     api      ${P_获取支付token}${token}
    ${response}  To Json  ${addr.content}
    ${payToken}     get from dictionary      ${response}     data
    [Return]    ${payToken}

支付订单
    [Arguments]  ${good_id}     ${formToken}    ${address_id}   ${cardToken}   ${token}     ${quantity}    ${type}="NORMAL"   ${promotionId}=0
    ${cartListStr}      set variable   [{"goodsId":${good_id},"labelId":0,"promotionId":${promotionId},"promotionType":${type},"quantity":${quantity}}]
    ${addr}     get request  api    ${P_支付}&cartListStr=${cartListStr}&formToken=${formToken}&address_id=${address_id}&cardToken=${card_token}&token=${token}
    should be equal as strings   ${addr.status_code}    200
    ${response}     To Json     ${addr.content}
    log to console      ${response}
    ${支付_msg}       get from dictionary     ${response}     msg
    should be equal as strings      ${支付_msg}       success


清空购物车
    [Arguments]     ${token}
    ${addr}     get request     api     ${P_清空购物车}${token}
    ${response}     To Json     ${addr.content}
    should be equal as strings   ${response['msg']}      success

*** Variables ***
${S_HSPgoods_id}          267559
${S_NORMALgoods_id}       #24767
${S_goods_quantity}       1
${S_HSPType}              "HSP"
${S_NORMALType}           "NORMAL"
${S_source}               LIST
${S_source1}              CART
${S_username}             1291823196@qq.com
${S_password}             12345678

${basket_data}          [{"action":"PLUS_INCREMENT","button":{"enableClick":true,"name":"buy now","type":"PLUS_MINUS_BUTTON"},"goodsId":${S_HSPgoods_id},"labelId":0,"promotionId":24767,"promotionType":${S_HSPType},"quantity":${S_goods_quantity}}]
#${checkout_data}      [{"quantity":${S_goods_quantity},"promotionId" :24767,"promotionType":${S_HSPType},"goodsId":${S_HSPgoods_id},"button" : {"type":"PLUS_MINUS_BUTTON", "name" : null,"enableClick":true}}]
${checkout_data}        [{"button":{"enableClick":true,"type":"PLUS_MINUS_BUTTON"},"goodsId":${S_HSPgoods_id},"labelId":0,"promotionId":0,"promotionType":${S_HSPType},"quantity":${S_goods_quantity}}]