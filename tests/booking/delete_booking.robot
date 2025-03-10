*** Settings ***
Documentation       Test Cases for deleting a bookings
Resource            ../../common/hooks.resource
Resource            ../../resources/booking.resource
Resource            ../../common/commons.robot
Suite Setup         Ping Server

*** Test Cases ***
Delete booking with valid credentials
    [Tags]  Delete
    Obtain Auth Token
    Add Booking
    Delete Booking with valid credentials

Delete booking with no authentication
    [Tags]  Delete
    Add Booking
    Delete Booking with no authentication

Delete non-existent booking
    [Tags]  Delete
    Obtain Auth Token
    Delete non-existent booking