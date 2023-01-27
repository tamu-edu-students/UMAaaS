Feature: Flag a comment or a tip or a post
    As a user
    So I can report an inappropriate comments or tips or posts
    I want to be able to report comments or tips or posts
    
Scenario: Flag button is displayed for authenticated users
    Given I am on the singapore page
    And I am logged_in
    And I see an Experience
    And Experience has a comment
    Then I should see class "flag"

Scenario: Flag button is not displayed for unauthenticated users
    Given I am on the singapore page
    And I am not logged_in
    And I see an Experience
    And Experience has a comment
    Then I should not see class "flag"

Scenario: Test flagging comment
    Given I see an Experience
    And Experience has a comment
    When I press comment_flag
    And The flag is not already set
    Then I should have a comment flag created
    
Scenario: Test unflagging comment
    Given I see an Experience
    And Experience has a comment
    When I press comment_flag
    And The flag is already set
    Then I should have a comment flag deleted

