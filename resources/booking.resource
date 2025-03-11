*** Settings ***
Documentation    Keywords used for booking endpoint
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Resource   ../common/constants.resource
Resource   ../common/commons.robot

*** Keywords ***
Get All Booking IDs
    Create Session      Get All     ${BASE_URL}     verify=True
    ${response}=        GET On Session     Get All     url=${BOOKING}
    Should Be Equal As Strings      ${response.status_code}     200
    @{BOOKINGIDS}=    Create List
    FOR    ${item}    IN    @{response.json()}
        Append To List    ${BOOKINGIDS}    ${item}[bookingid]
    END
    Set Suite Variable      ${BOOKING_IDS}      ${BOOKING_IDS}

Add Booking
    ${bookingdates}=   Create Dictionary
    ...                checkin=${CHECKIN}
    ...                checkout=${CHECKOUT}
    ${newbooking}=     Create Dictionary
    ...                firstname=${FIRSTNAME}
    ...                lastname=${LASTNAME}
    ...                totalprice=${TOTALPRICE} 
    ...                depositpaid=${DEPOSITPAID} 
    ...                additionalneeds=${ADDITIONALNEEDS}
    ...                bookingdates=${bookingdates} 
    ${HEADERS}=        Create Dictionary
    ...                Content-Type=${CONTENT_TYPE}
    ...                User-Agent=RobotFramework
    Create Session     Add Booking     ${BASE_URL}     headers=${HEADERS}   verify=True
    ${response}=       POST On Session    Add Booking    url=${BOOKING}   json=${newbooking}  
    Should Be Equal As Strings      ${response.status_code}     200
    Dictionary Should Contain Key    dictionary=${response.json()}    key=bookingid
    ${NEW_ID}=      Get From Dictionary    dictionary=${response.json()}    key=bookingid
    Set Suite Variable      ${NEW_ID}
    ${RESPONSE_BODY}=    Set Variable    ${response.json()}
    Set Suite Variable      ${RESPONSE_BODY}

Check New Booking Details Are Correct
    Add Booking
    Create Session      Get New     ${BASE_URL}     verify=True
    ${response}=        GET On Session     Get New     url=${BOOKING}/${NEW_ID}
    Should Be Equal As Strings        ${response.status_code}     200
    Dictionary Should Contain Item    dictionary=${response.json()}                    key=firstname          value=${FIRSTNAME}
    Dictionary Should Contain Item    dictionary=${response.json()}                    key=lastname           value=${LASTNAME}
    Dictionary Should Contain Item    dictionary=${response.json()}                    key=totalprice         value=${TOTALPRICE}
    Dictionary Should Contain Item    dictionary=${response.json()}                    key=depositpaid        value=${DEPOSITPAID}
    Dictionary Should Contain Item    dictionary=${response.json()}                    key=additionalneeds    value=${ADDITIONALNEEDS}
    Dictionary Should Contain Item    dictionary=${response.json()["bookingdates"]}    key=checkin            value=${CHECKIN}
    Dictionary Should Contain Item    dictionary=${response.json()["bookingdates"]}    key=checkout           value=${CHECKOUT}

Get New Booking ID By Name
    Add Booking
    Create Session      Get ID By Name      ${BASE_URL}     verify=True
    ${response}=        GET On Session     Get ID By Name      url=${BOOKING}/?firstname=${FIRSTNAME}&lastname=${LASTNAME}
    Should Be Equal As Strings      ${response.status_code}     200
    @{bookingids}=    Create List
    FOR    ${item}    IN    @{response.json()}
        Append To List    ${bookingids}    ${item["bookingid"]}
    END
    List Should Contain Value    ${bookingids}    ${NEW_ID}

Get New Booking ID By Date
    Add Booking
    Create Session      Get ID By Date      ${BASE_URL}     verify=True
    ${response}=        GET On Session     Get ID By Date      url=${BOOKING}/?checkin=2025-08-29&checkout=${CHECKOUT}
    Should Be Equal As Strings      ${response.status_code}     200
    @{bookingids}=    Create List
    FOR    ${item}    IN    @{response.json()}
        Append To List    ${bookingids}    ${item["bookingid"]}
    END
    List Should Contain Value    ${bookingids}    ${NEW_ID}

Update New Booking
    ${bookingdates}=   Create Dictionary
    ...                checkin=${CHECKIN}
    ...                checkout=${CHECKOUT}
    ${updatebooking}=  Create Dictionary
    ...                firstname=${FIRSTNAME}
    ...                lastname=${LASTNAME}
    ...                totalprice=0
    ...                depositpaid=${DEPOSITPAID} 
    ...                additionalneeds=${ADDITIONALNEEDS}
    ...                bookingdates=${bookingdates} 
    ${HEADERS}=        Create Dictionary
    ...                Content-Type=${CONTENT_TYPE}
    ...                Cookie=token=${TOKEN}
    Create Session     Update Booking      ${BASE_URL}     verify=True
    ${response}=        PUT On Session     Update Booking      url=${BOOKING}/${NEWID}     json=${updatebooking}       headers=${HEADERS}
    Should Be Equal As Strings      ${response.status_code}     200

Partial Update New Booking
    ${partialupdatebooking}=        Create Dictionary
    ...                             totalprice=1000
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    ...                  Cookie=token=${TOKEN}
    Create Session  Partial Update Booking      ${BASE_URL}     verify=True
    ${response}=        PATCH On Session     Partial Update Booking      url=${BOOKING}/${NEWID}     json=${partialupdatebooking}        headers=${HEADERS}
    Should Be Equal As Strings      ${response.status_code}     200

Delete Booking with valid credentials
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    ...                  Cookie=token=${TOKEN}
    Create Session      Delete Booking      ${BASE_URL}     verify=True
    ${response}=        DELETE On Session     Delete Booking      url=${BOOKING}/${NEWID}     headers=${HEADERS}
    Should Be Equal As Strings      ${response.status_code}     201
    ${response}=        GET On Session     Delete Booking      url=${BOOKING}/${NEWID}     headers=${HEADERS}    expected_status=404    msg=Status code should be 404.

Delete Booking with no authentication
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    Create Session      Delete Booking      ${BASE_URL}     verify=True
    ${response}=        DELETE On Session     Delete Booking      url=${BOOKING}/${NEWID}     headers=${HEADERS}    expected_status=403    msg=Status code should be 403.

Delete non-existent booking
    ${HEADERS}=          Create Dictionary
    ...                  Content-Type=${CONTENT_TYPE}
    ...                  Cookie=token=${TOKEN}
    Create Session      Delete Booking      ${BASE_URL}     verify=True
    ${response}=        DELETE On Session     Delete Booking      url=${BOOKING}/999999     headers=${HEADERS}    expected_status=405    msg=Status code should be 405.

Validate JSON Schema
    Validate Json By Schema File    ${RESPONSE_BODY}    data/json_schema.json