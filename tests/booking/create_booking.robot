*** Settings ***
Documentation    Test Cases for adding a new booking
Resource         ../../resources/booking.resource
Resource         ../../common/hooks.resource
Suite Setup      Ping Server

*** Test Cases ***
Add New Booking
    [Tags]  booking
    Add Booking