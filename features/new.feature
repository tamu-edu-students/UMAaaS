Feature: create review page
    As a user
    So that I can add reviews to places I have been
    I want to give feedback on trips abroad

Scenario: Test for review presence
    Given I am on the review page
    Then I should see class "reviews-card"
    Then I should see id "new_review"
