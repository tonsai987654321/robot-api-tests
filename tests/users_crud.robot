*** Settings ***
Resource          ../resources/api_keywords.resource
Resource          ../resources/user_keywords.resource
Resource          ../resources/variables.robot
Suite Setup       Create API Session
Suite Teardown    Delete API Session

*** Test Cases ***
GET Users Returns Non-Empty List
    ${response}=    GET On Session    reqres    /users    expected_status=200
    ${data}=        Get From Dictionary    ${response.json()}    data
    Should Not Be Empty    ${data}

GET Single User Returns Correct ID
    ${response}=    Get User    ${VALID_USER_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    ${data}=        Get From Dictionary    ${response.json()}    data
    Should Be Equal As Integers    ${data}[id]    ${VALID_USER_ID}

POST Create User Returns 201 With Data
    ${response}=    Create User    John Doe    QA Engineer
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[name]    John Doe
    Should Be Equal    ${body}[job]     QA Engineer

PUT Update User Returns 200 With Updated Fields
    ${response}=    Update User    ${VALID_USER_ID}    Jane Doe    Developer
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[name]    Jane Doe
    Should Be Equal    ${body}[job]     Developer

PATCH User Returns 200 With Patched Field
    ${response}=    Patch User    ${VALID_USER_ID}    Updated Name
    ${body}=        Set Variable    ${response.json()}
    Should Be Equal    ${body}[name]    Updated Name

DELETE User Returns 204
    ${response}=    Delete User    ${VALID_USER_ID}
    Should Be Equal As Integers    ${response.status_code}    204
