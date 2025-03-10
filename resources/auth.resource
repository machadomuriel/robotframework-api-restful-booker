*** Settings ***
Documentation    Keywords used for auth endpoint
Library    RequestsLibrary
Library    Collections
Resource   ../common/constants.resource

*** Keywords ***
Verify Successful Authentication with valid credentials
    ${HEADERS}=         Create Dictionary
    ...                 Content-Type=${CONTENT_TYPE}
    ...                 User-Agent=RobotFramework
    Create Session      auth        ${BASE_URL}     verify=True
    ${response}=        POST On Session     auth        url=${AUTH}
    ...    data={"username":"${USERNAME}","password":"${PASSWORD}"}
    ...    headers=${HEADERS}
    ...    expected_status=200    msg=Status code should be 200
    Dictionary Should Contain Key    dictionary=${response.json()}    key=token
    ${token}=           Get From Dictionary     ${response.json()}      token
    Should Not Be Empty    ${token}

Verify unsuccessful authentication with wrong password
    ${HEADERS}=         Create Dictionary
    ...                 Content-Type=${CONTENT_TYPE}
    ...                 User-Agent=RobotFramework
    Create Session      auth        ${BASE_URL}     verify=True
    ${response}=        POST On Session     auth        url=${AUTH}
    ...    data={"username":"${USERNAME}","password":"wrong_password"}
    ...    headers=${HEADERS}
    ...    expected_status=200    msg=Status code should be 200
    Dictionary Should Contain Key    dictionary=${response.json()}    key=reason
    ${reason}=           Get From Dictionary     ${response.json()}      reason
    Should Be Equal    ${reason}    Bad credentials

Verify unsuccessful authentication with no payload
    ${HEADERS}=         Create Dictionary
    ...                 Content-Type=${CONTENT_TYPE}
    ...                 User-Agent=RobotFramework
    Create Session      auth        ${BASE_URL}     verify=True
    ${response}=        POST On Session     auth        url=${AUTH}
    ...    headers=${HEADERS}
    ...    expected_status=200    msg=Status code should be 200
    Dictionary Should Contain Key    dictionary=${response.json()}    key=reason
    ${reason}=           Get From Dictionary     ${response.json()}      reason
    Should Be Equal    ${reason}    Bad credentials