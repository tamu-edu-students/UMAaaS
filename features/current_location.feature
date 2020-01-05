Feature: Add Current Location Dropdown Menu
    As a developer
    So that we can use current location
    I want to find places nearby

Scenario: Test for option presence
    Given I am on the home page
    When I fill in "near" with "C"
    Then I should see class "option"
