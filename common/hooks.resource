*** Settings ***
Documentation       Keywords to be used in the setup/teardown sessions
Library     RequestsLibrary
Resource    ../common/constants.resource

*** Keywords ***
Ping Server
    Create Session      ping        ${BASE_URL}     verify=True
    ${response}=        GET On Session     ping        url=${PING}
    Should Be Equal As Strings      ${response.status_code}     201