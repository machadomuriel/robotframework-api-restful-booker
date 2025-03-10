*** Settings ***
Documentation    This file contains the settings for the API test suite
*** Variables ***
#ENDPOINTS     
${BASE_URL}             https://restful-booker.herokuapp.com
${AUTH}                 /auth
${BOOKING}              /booking
${PING}                 /ping

#HEADERS      
${CONTENT_TYPE}         application/json

#AUTH                   ---
${USERNAME}             admin          #Ideally, this value should be provided in an environment variable.
${PASSWORD}             password123    #Ideally, this value should be provided in an environment variable.

#BOOKING DETAILS        ---
${CHECKIN}              2025-08-30
${CHECKOUT}             2025-09-10
${FIRSTNAME}            Anthony
${LASTNAME}             ODonnell
${TOTALPRICE}           ${{500}}    # This syntax allows you to attribute an integer value to a variable. Otherwise, it would be a string.
${DEPOSITPAID}          ${True}     # This syntax allows you to attribute a boolean value to a variable. Otherwise, it would be a string.
${ADDITIONALNEEDS}      Breakfast