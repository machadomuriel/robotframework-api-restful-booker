*** Settings ***
Documentation       Common keywords used by all tests
Library    RequestsLibrary
Library    Collections
Resource    ../common/constants.resource

*** Keywords ***
Obtain Auth Token
    ${HEADERS}=         Create Dictionary
    ...                 Content-Type=${CONTENT_TYPE}
    ...                 User-Agent=RobotFramework
    Create Session      Obtain Token        ${BASE_URL}     verify=True
    ${response}=        POST On Session     Obtain Token        url=${AUTH}     data={"username":"${USERNAME}","password":"${PASSWORD}"}      headers=${HEADERS}
    Should Be Equal As Strings      ${response.status_code}     200
    Dictionary Should Contain Key    dictionary=${response.json()}    key=token
    ${TOKEN}=           Get From Dictionary     ${response.json()}      token
    Set Suite Variable      ${TOKEN}        ${TOKEN}