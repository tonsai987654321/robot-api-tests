*** Settings ***
Resource    api_keywords.resource

*** Keywords ***
Login User
    [Arguments]    &{body}
    ${response}=    POST On Session    reqres    /auth/login    json=&{body}    expected_status=any
    RETURN    ${response}

Get Authenticated User
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    reqres    /auth/me    headers=&{headers}    expected_status=any
    RETURN    ${response}
