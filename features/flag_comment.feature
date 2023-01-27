Feature: Flag a comment
    As a user
    So I can report an innapropriacte comments
    I want to keep comments clean

# Scenario: Test for flag presence 
#     Given I am on the home page
#     Then I should see id "index-search-box"

Scenario: Test flagging comment
    Given I see a comment
    When I press comment_flag
    And The flag is not already set
    Then I should have a comment flag created
    
Scenario: Test flagging comment
    Given I see a comment
    When I press comment_flag
    And The flag is already set
    Then I should have a comment flag deleted