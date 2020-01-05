Feature: Create a basic card
    As a developer
    So that we can have a base element
    I want to expand this component with sub-components

Scenario: Test for card presence
    Given I am on the home page
    When I fill in "near" with "College Station"
    When I fill in "find" with "Tacos"
    When I press "button"
    Then I should see class "our-card"
