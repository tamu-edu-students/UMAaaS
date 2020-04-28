Feature: Show Tips and Experiences
    As a user
    I want to see Tips and Experiences
    So that I know what to do abroad

Scenario: Test for Tips presence
    Given I am on the singapore page
    Then I should see id "portal-sort-tips"

Scenario: Test for Experiences presence
    Given I am on the singapore page
    Then I should see id "portal-sort-experiences"
    
Scenario: Test for Experiences presence
    Given I am on the singapore page
    Then I should see id "portal-sort-experiences"

Scenario: Test for search results
    Given I am on the singapore search page
    Then I should see "No search results"