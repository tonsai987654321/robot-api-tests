*** Settings ***
Resource          ../resources/api_keywords.resource
Resource          ../resources/user_keywords.resource
Resource          ../resources/auth_keywords.resource
Resource          ../resources/variables.robot
Suite Setup       Create API Session
Suite Teardown    Delete API Session

*** Test Cases ***
GET Non-Existent User Returns 404
    ${response}=    Get User    ${INVALID_USER_ID}
    Should Be Equal As Integers    ${response.status_code}    404

POST Register With Missing Password Returns 400 Error Message
    &{body}=    Create Dictionary    email=${TEST_EMAIL}
    ${response}=    Register User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error

POST Login With Unrecognised Email Returns 400 Error Message
    &{body}=    Create Dictionary    email=nobody@example.com    password=anything
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error

GET Delayed Response Returns 200 Within Timeout
    ${response}=    GET On Session    reqres    /users    params=delay=3    expected_status=200
    ${data}=        Get From Dictionary    ${response.json()}    data
    Should Not Be Empty    ${data}
