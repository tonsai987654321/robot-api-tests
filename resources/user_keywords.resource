*** Settings ***
Resource    api_keywords.resource

*** Keywords ***
Get User
    [Arguments]    ${user_id}
    ${response}=    GET On Session    reqres    /users/${user_id}    expected_status=any
    RETURN    ${response}

Create User
    [Arguments]    ${first_name}    ${last_name}
    &{body}=    Create Dictionary    firstName=${first_name}    lastName=${last_name}
    ${response}=    POST On Session    reqres    /users/add    json=&{body}    expected_status=201
    RETURN    ${response}

Update User
    [Arguments]    ${user_id}    ${first_name}    ${last_name}
    &{body}=    Create Dictionary    firstName=${first_name}    lastName=${last_name}
    ${response}=    PUT On Session    reqres    /users/${user_id}    json=&{body}    expected_status=200
    RETURN    ${response}

Patch User
    [Arguments]    ${user_id}    ${first_name}
    &{body}=    Create Dictionary    firstName=${first_name}
    ${response}=    PATCH On Session    reqres    /users/${user_id}    json=&{body}    expected_status=200
    RETURN    ${response}

Delete User
    [Arguments]    ${user_id}
    ${response}=    DELETE On Session    reqres    /users/${user_id}    expected_status=200
    RETURN    ${response}
