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

POST Login With Missing Password Returns 400
    &{body}=    Create Dictionary    username=${TEST_USERNAME}
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    message

POST Login With Wrong Credentials Returns 400
    &{body}=    Create Dictionary    username=nobody    password=wrongpass
    ${response}=    Login User    &{body}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    message

GET Protected Endpoint Without Token Returns 401
    ${response}=    Get Authenticated User    invalid_token
    Should Be Equal As Integers    ${response.status_code}    401
