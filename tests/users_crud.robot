*** Settings ***
Resource          ../resources/api_keywords.resource
Resource          ../resources/user_keywords.resource
Resource          ../resources/variables.robot
Suite Setup       Create API Session
Suite Teardown    Delete API Session

*** Test Cases ***
GET Users Returns Non-Empty List
    ${response}=    GET On Session    reqres    /users    expected_status=200
    ${data}=        Get From Dictionary    ${response.json()}    users
    Should Not Be Empty    ${data}

GET Single User Returns Correct ID
    ${response}=    Get User    ${VALID_USER_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    ${data}=        Get From Dictionary    ${response.json()}    id
    Should Be Equal As Integers    ${data}    ${VALID_USER_ID}

GET Non-Existent User Returns 404
    ${response}=    Get User    ${INVALID_USER_ID}
    Should Be Equal As Integers    ${response.status_code}    404

POST Create User Returns 201 With Data
    ${response}=    Create User    John Doe    QA Engineer
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[firstName]    John
    Should Be Equal    ${body}[lastName]     Doe

PUT Update User Returns 200 With Updated Fields
    ${response}=    Update User    ${VALID_USER_ID}    Jane    Doe
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[firstName]    Jane

PATCH User Returns 200 With Patched Field
    ${response}=    Patch User    ${VALID_USER_ID}    Updated
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[firstName]    Updated

DELETE User Returns 200
    ${response}=    Delete User    ${VALID_USER_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[isDeleted]    ${True}
