*** Settings ***
Documentation       API Test using RESTfulBooker application
Resource            ../../common/hooks.resource
Resource            ../../resources/booking.resource
Resource            ../../common/commons.robot
Suite Setup         Ping Server
*** Test Cases ***

Update New Booking
    [Tags]  Put
    Obtain Auth Token
    Add Booking
    Update New Booking

Partial Update New Booking
    [Tags]  Patch
    Obtain Auth Token
    Add Booking
    Partial Update New Booking