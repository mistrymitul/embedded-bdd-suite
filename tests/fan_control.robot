*** Settings ***
Documentation     BDD-style tests for chassis fan speed control via serial CLI
Library           ${CURDIR}/resources/SerialLibrary.py

*** Variables ***
${PORT}           /dev/ttyUSB0
${BAUD}           115200
${TIMEOUT}        2

*** Test Cases ***

Scenario: Set fan to 50 percent speed
    [Tags]    regression    fan
    Given the chassis is powered on
    When I send the command    SET_FAN_SPEED 50
    Then the response should be    OK
    And the fan speed should read    50

Scenario: Set fan to maximum speed
    [Tags]    regression    fan
    Given the chassis is powered on
    When I send the command    SET_FAN_SPEED 100
    Then the response should be    OK
    And the fan speed should read    100

Scenario: Reject invalid fan speed above maximum
    [Tags]    regression    validation
    Given the chassis is powered on
    When I send the command    SET_FAN_SPEED 150
    Then the response should be    ERROR: VALUE_OUT_OF_RANGE