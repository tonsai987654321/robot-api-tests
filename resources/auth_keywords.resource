*** Settings ***
Resource    api_keywords.resource

*** Keywords ***
Register User
    [Arguments]    &{body}
    ${response}=    POST On Session    reqres    /register    json=&{body}    expected_status=any
    RETURN    ${response}

Login User
    [Arguments]    &{body}
    ${response}=    POST On Session    reqres    /login    json=&{body}    expected_status=any
    RETURN    ${response}
