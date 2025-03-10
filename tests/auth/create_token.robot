*** Settings ***
Documentation    Test Cases for authentication endpoint
Resource         ../../resources/auth.resource
Resource         ../../common/hooks.resource
Suite Setup      Ping Server

*** Test Cases ***
Successful Authentication
    [Tags]  Auth
    Verify Successful Authentication with valid credentials

Unsuccessful Authentication - wrong password
    [Tags]  Auth
    Verify unsuccessful authentication with wrong password

Unsuccessful Authentication - no payload
    [Tags]  Auth
    Verify unsuccessful authentication with no payload