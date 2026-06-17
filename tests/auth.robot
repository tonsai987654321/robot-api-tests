*** Settings ***
Resource          ../resources/api_keywords.resource
Resource          ../resources/auth_keywords.resource
Resource          ../resources/variables.robot
Suite Setup       Create API Session
Suite Teardown    Delete API Session

*** Test Cases ***
POST Login With Valid Credentials Returns Token
    &{body}=    Create Dictionary    username=${TEST_USERNAME}    password=${TEST_PASSWORD}
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    accessToken

POST Login With Invalid Credentials Returns 400
    &{body}=    Create Dictionary    username=wronguser    password=wrongpassword
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    message

GET Authenticated User With Valid Token Returns User Data
    &{body}=    Create Dictionary    username=${TEST_USERNAME}    password=${TEST_PASSWORD}
    ${login}=       Login User    &{body}
    ${token}=       Get From Dictionary    ${login.json()}    accessToken
    ${response}=    Get Authenticated User    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    username

GET Authenticated User Without Token Returns 401
    ${response}=    Get Authenticated User    invalid_token
    Should Be Equal As Integers    ${response.status_code}    401
