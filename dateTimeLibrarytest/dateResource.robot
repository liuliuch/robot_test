*** Settings ***
Documentation    Suite description
Library    DateTime


*** Test Cases ***
添加时间到日期
    [Documentation]  add time to date
#    date: 日期以支持的日期格式之一添加时间。
#    time: 以支持的时间格式之一添加的时间。
#    result_format: 返回日期的格式。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
#    date_format: 可能的自定义时间戳格式date。
    ${date}    add time to date    2014-05-28 12：05：03.111	    7days
    Should Be Equal     ${date}    2014-06-04 12:05:03.111

    ${date}	add time to date	2014-05-28 12:05:03.111 	01:02:03:004
    should be equal     ${date}     2014-05-28 13:07:06.115

给时间添加时间
    [Documentation]  add time to time
#    time1: 第一次使用其中一种支持的时间格式。
#    time2: 第二次使用其中一种支持的时间格式。
#    result_format: 返回时间的格式。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
    ${time}    Add Time To Time    3 hours 5 minutes      01:02:03       timer       exclude_millis=yes
    log    ${time}
    should be equal      ${time}	  04:07:03

转换日期
    [Documentation]  conert date
#    date: 日期采用其中一种支持的日期格式。
#    result_format: 返回日期的格式。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
#    date_format: 指定可能的自定义时间戳格式。
    ${date} 	Convert Date	 20140528 12:05:03.111
    Should Be Equal	   ${date}	  2014-05-28 12:05:03.111

    ${date}     Convert Date        ${date}     epoch    #exclude_millis=yes
    log      ${date}
    Should Be Equal     ${date}     ${1401249903.111}    #1401249903.0

    ${date}     Convert Date        5.28.2014 12:05     exclude_millis=yes      date_format=%m.%d.%Y %H:%M
    Should Be Equal	   ${date}      2014-05-28 12:05:00

转换时间
    [Documentation]  convert time
#    time: 以支持的时间格式之一的时间。
#    result_format: 返回时间的格式。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
    ${time}     Convert Time        10 seconds
    Should Be Equal     ${time}     ${10}

    ${time}     Convert Time        1:00:01     verbose
    Should Be Equal     ${time}     1 hour 1 second

    ${time}     Convert Time        ${3661.5}       timer       #exclude_milles=yes
    Should Be Equal     ${time}     01:01:02.500    #01:01:02

获取当前时间
    [Documentation]  get current date
#    time_zone: 获取此时区的当前时间。目前只有local（默认）并且UTC受支持。
#    increment: 可选的时间增量以一种支持的时间格式添加到返回的日期。可以是负的。
#    result_format: 返回日期的格式（请参阅日期格式）。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
    ${date}     Get Current Date
    log    ${date}      #2018-06-06 11:09:29.984

    ${date} =	Get Current Date	UTC     #时区
    log     ${date}     #2018-06-06 03:09:29.985

    ${date} =	Get Current Date	increment=02:30:00	#增量，也可以是负的
    log 	${date}     #2018-06-06 13:39:29.986

    ${date} =	Get Current Date	UTC	    -5 hours
    log     ${date}     #2018-06-05 22:09:29.987

    ${date} =	Get Current Date	result_format=datetime
    log     ${date}     #2018-06-06 11:09:29.987926
    Should Be Equal	${date.year}	${2018}
    Should Be Equal	${date.month}	${6}

从日期减去日期
    [Documentation]  Subtract Date From Date
#    date1: 从其中一种支持的日期格式中减去另一日期的日期。
#    date2: 在一种支持的日期格式中减去的日期。
#    result_format: 返回时间的格式（请参阅时间格式）。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
#    date1_format: 可能的自定义时间戳格式date1。
#    date2_format: 可能的自定义时间戳格式date2。
    ${time}     Subtract Date From Date     2014-05-28 12:05:52     2014-05-28 12:05:10
    Should Be Equal     ${time}     ${42}

    ${time}     Subtract Date From Date     2014-05-28 12:05:52     2014-05-27 12:05:10     verbose
    Should Be Equal     ${time}     1 day 42 seconds

从日期减去是时间
    [Documentation]  Subtract Time From Date
#    date: 在其中一种支持的日期格式中减去时间的日期。
#    time: 在一种支持的时间格式中减去的时间。
#    result_format: 返回日期的格式。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
#    date_format: 可能的自定义时间戳格式date。
    ${currentDate}      get current date    #2018-06-06 14:10:45.933
    ${date}     Subtract Time From Date     ${currentDate}     7 hours
    log     ${date}     #2018-06-06 07:10:45.933
    ${date}     Subtract Time From Date     ${currentDate}     01:02:03:004
    log     ${date}     #2018-06-06 13:08:42.929

从时间减去时间
    [Documentation]  Subtract Time From Time
#    time1: 时间从其中一种支持的时间格式中减去另一次。
#    time2: 时间减去一个支持的时间格式。
#    result_format: 返回时间的格式。
#    exclude_millis:设置为任何真值时，按照毫秒处理的说明进行舍入和舍弃毫秒。
    ${currentDate}      get current date
    ${currentTime}      set variable    ${currentDate[11:19]}    #14:25:33  robot framework支持python的用法
    ${time}     Subtract Time From Time     ${currentTime}        100
    log     ${time}     #51833.0

    ${time}     Subtract Time From Time     ${currentTime}     1 minute        compact
    log    ${time}      #14h 24min 33s
*** Keywords ***
