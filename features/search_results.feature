Feature: display search results
    As a user
    So that I can see the most relevant content related to my search
    I want to view all relevant results

Scenario: Test that Mad Taco has a page
    Given I am on the home page
    When I fill in "near" with "College Station"
    When I fill in "find" with "Tacos"
    When I press "button"
    Then I should see a "Mad Taco" card
    When I follow "card_0"
    Then I should see "Mad Taco"