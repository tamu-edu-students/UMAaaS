Feature: Create search bar
    As a user
    So I can search through many points of interests
    I want to find reviews for places

Scenario: Test for search bar presence 
    Given I am logged in with Google
    Then I should see id "search-field"

Scenario: Test search works correctly 
    Given I am logged in with Google
    Given I am on the singapore page
    Then I enter text in the search bar
    Then I should be redirected to the test search page
