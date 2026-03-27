*** Settings ***
Documentation     BDD-style tests for chassis fan speed control via serial CLI
Library           ${CURDIR}/resources/SerialLibrary.py

*** Variables ***
${PORT}           /dev/ttyUSB0
${BAUD}           115200
${TIMEOUT}        2

*** Test Cases ***

# -------------------------------------------------------------------
# BACKGROUND behaviour is handled by calling the setup keyword below.
# Robot Framework's "Test Setup" runs it before every single test.
# -------------------------------------------------------------------

Scenario Outline: Valid fan speeds should return OK
    [Tags]    regression    fan    valid
    [Template]    Valid fan speed template
    0
    25
    50
    75
    100

Scenario Outline: Invalid fan speeds should return error
    [Tags]    regression    fan    validation
    [Template]    Invalid fan speed template
    -1
    101
    150
    999

Scenario: Fan speed set to minimum boundary
    [Tags]    regression    boundary
    When I send the command    SET_FAN_SPEED 0
    Then the response should be    OK
    And the fan speed should read    0

Scenario: Fan speed set to maximum boundary
    [Tags]    regression    boundary
    When I send the command    SET_FAN_SPEED 100
    Then the response should be    OK
    And the fan speed should read    100

*** Keywords ***

Valid fan speed template
    [Arguments]    ${speed}
    When I send the command    SET_FAN_SPEED ${speed}
    Then the response should be    OK
    And the fan speed should read    ${speed}

Invalid fan speed template
    [Arguments]    ${speed}
    When I send the command    SET_FAN_SPEED ${speed}
    Then the response should be    ERROR: VALUE_OUT_OF_RANGE

*** Settings ***
Test Setup    the chassis is powered on