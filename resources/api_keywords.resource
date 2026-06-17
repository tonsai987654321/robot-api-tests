*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   variables.robot

*** Keywords ***
Create API Session
    Create Session    reqres    ${BASE_URL}    timeout=${TIMEOUT}

Delete API Session
    Delete All Sessions
