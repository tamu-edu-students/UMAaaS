Feature: Send automated email to banned users
    As an admin,
    when a user is banned,
    I want to send an automated email to the user explaining why they were banned


Scenario: Test for go to the banpage
    Given I am logged in with Google as an Admin
    Given I am on the user page
    Then I should see "Ban User"
    When I follow "Ban User"
    Then I am on the ban_comment page

Scenario: Test for ban user
    Given I am logged in with Google as an Admin
    Given I am on the user page
    Then I should see "Ban User"
    When I follow "Ban User"
    Then I am on the ban_comment page
    When I fill in "ban_reason" with "You have been banned"
    And I press "Ban User"
    Then I should see "Test User has been banned."
