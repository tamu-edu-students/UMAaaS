Feature: create show page
    As a user
    So that I can see the details of any location from abroad trips
    I want to be informed of where I'm going

Scenario: Test the show page
    Given I am on the show_mad_taco page
    Then I should see class "show-card"
    Then I should see class "show-image"
    Then I should see class "show-title-box"
    Then I should see class "show-rating"
    Then I should see id "price-info"
    Then I should see id "leave_review"
    Then I should see class "show-business-hours"
