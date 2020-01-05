Feature: Get data from Yelp
    As a developer
    So that we can view local restaurants
    I want to use the yelp API to supplement our own database

Scenario: Test for College Station Tacos
    Given I am on the home page
    When I fill in "near" with "College Station"
    When I fill in "find" with "Tacos"
    When I press "button"
    Then I should see a "Mad Taco" card
    Then I should see a "Fuego Tortilla Grill" card
    Then I should see a "Torchy's Tacos" card
    Then I should see a "Tacobar" card
    Then I should see a "Aggie Taqueria" card