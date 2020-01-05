Feature: Fill in Emergency Page Details
As a user
So that I can reference TAMU emergency resources
I want to be able to have easy access to TAMU emergency contacts.

Scenario: Test for TAMU emergency resources
    Given I am on the emergency page
    Then I should see class "tamu"
    Then I should see class "europe"
    Then I should see class "south_america"
    Then I should see class "asia"
    Then I should see class "africa"
