Feature: Create a menu bar
    As a developer
    I want a menu bar to show on every page
    So that I can quickly navigate the website

Scenario: Test for menu presence
    Given I am on the home page
    Then I should see class "nav"
    Then I should see id "tamu_logo_link"
    Then I should see id "contacts"
    Then I should see id "login"

Scenario: Test get help link
    Given I am on the home page
    When I follow "contacts"
    Then I should see class "emergency-background"

Scenario: Test the logo links back to index
    Given I am on the home page
    When I follow "tamu_logo_link"
    Then I should see class "nav"
