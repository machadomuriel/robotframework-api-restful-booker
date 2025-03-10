*** Settings ***
Documentation       Test Cases for getting bookings
Resource            ../../common/hooks.resource
Resource            ../../common/constants.resource
Resource            ../../resources/booking.resource
Test Timeout        1 minute
Suite Setup         Ping Server

*** Test Cases ***
Get All Bookings IDs
     [Tags]  Get
    Get All Booking IDs

Validate New Booking Details
    [Tags]  Get
    Check New Booking Details Are Correct

Get New Booking ID By Name
    [Tags]  Get
    Get New Booking ID By Name

Get New Booking ID By Date
    [Tags]  Get
    Get New Booking ID By Date