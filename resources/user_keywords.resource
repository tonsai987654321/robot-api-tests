*** Settings ***
Resource    api_keywords.resource

*** Keywords ***
Get User
    [Arguments]    ${user_id}
    ${response}=    GET On Session    reqres    /users/${user_id}    expected_status=any
    RETURN    ${response}

Create User
    [Arguments]    ${name}    ${job}
    &{body}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST On Session    reqres    /users    json=&{body}    expected_status=201
    RETURN    ${response}

Update User
    [Arguments]    ${user_id}    ${name}    ${job}
    &{body}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    PUT On Session    reqres    /users/${user_id}    json=&{body}    expected_status=200
    RETURN    ${response}

Patch User
    [Arguments]    ${user_id}    ${name}
    &{body}=    Create Dictionary    name=${name}
    ${response}=    PATCH On Session    reqres    /users/${user_id}    json=&{body}    expected_status=200
    RETURN    ${response}

Delete User
    [Arguments]    ${user_id}
    ${response}=    DELETE On Session    reqres    /users/${user_id}    expected_status=204
    RETURN    ${response}
