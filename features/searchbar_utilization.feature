Feature: Get info from Search box
    As a developer
    So that we can query results
    I want to pass user info to the yelp API

Scenario: Test that search bar has multiple parts
    Given I am on the home page
    Then I should see class "search-flex"
    Then I should see id "sb_near"
    Then I should see id "sb_find"
    Then I should see id "sb_search"
  
