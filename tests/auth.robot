*** Settings ***
Resource          ../resources/api_keywords.resource
Resource          ../resources/auth_keywords.resource
Resource          ../resources/variables.robot
Suite Setup       Create API Session
Suite Teardown    Delete API Session

*** Test Cases ***
POST Register With Valid Credentials Returns Token
    &{body}=    Create Dictionary    email=${TEST_EMAIL}    password=${TEST_PASSWORD}
    ${response}=    Register User    &{body}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token

POST Register With Missing Password Returns 400
    &{body}=    Create Dictionary    email=${TEST_EMAIL}
    ${response}=    Register User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error

POST Login With Valid Credentials Returns Token
    &{body}=    Create Dictionary    email=${TEST_EMAIL}    password=${LOGIN_PASSWORD}
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token

POST Login With Unrecognised Email Returns 400
    &{body}=    Create Dictionary    email=unknown@example.com    password=anything
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error
