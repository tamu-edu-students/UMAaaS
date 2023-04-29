Feature: Send automated email to banned users
    As an admin,
    So that I can manage the users
    I should be able to control the users of the application

Scenario: Test for go to the banpage
    Given I am logged in with Google as an Admin
    Given I am on the users page
    When I follow "Edit User"
    Then I should see "Ban User"
    When I follow "Ban User"
    Then I am on the ban_comment page

Scenario: Test for ban user
    Given I am logged in with Google as an Admin
    Given I am on the users page
    When I follow "Edit User"
    Then I should see "Ban User"
    When I follow "Ban User"
    Then I am on the ban_comment page
    When I fill in "ban_reason" with "You have been banned"
    And I press "Ban User"
    Then I should see "Test User 2 has been banned"

Scenario: Ban and Unban a user
    Given I am logged in with Google as an Admin
    Given I am on the users page
    When I follow "Edit User"
    When I follow "Ban User"
    Then I am on the ban_comment page
    When I fill in "ban_reason" with "You have been banned"
    And I press "Ban User"
    Then I should see "Test User 2 has been banned." 
    When I refresh the page   
    Given I am on the users page
    When I click on "show-banned-users"
    Then I should see "Test User 2"
    When I follow "Edit User"
    When I follow "Unban User"
    Given I am on the users page
    Then I should see "Test User 2"

Scenario: Promote and Demote an user to admin
    Given I am logged in with Google as an Admin
    Given I am on the users page
    When I follow "Edit User"
    When I follow "Promote to Admin"
    When I refresh the page
    Given I am on the users page
    When I follow "Edit User"   
    Then I should see "Demote Admin"
    When I follow "Demote Admin"
    When I refresh the page 
    Given I am on the users page
    When I follow "Edit User"  
    Then I should see "Promote to Admin"

Scenario: Test the search feature in user page
    Given I am logged in with Google as an Admin
    Given I am on the users page
    Then I enter "test" in the search bar
    Then I should be redirected to the test user search page

Scenario: Test the remote ban feature 
    Given I am logged in with Google as User 2
    When I follow "Add Tip"
    When I fill in "Tip" with "Test Tip"
    And I press "Save"
    When I click on "flag"
    When I refresh the page 
    Given I am logged in with Google as an Admin
    When I follow "Flags"
    Then I should see "Ban"
    When I click on "ban"
    When I refresh the page 
    Given I am on the users page
    When I click on "show-banned-users"
    Then I should see "Test User 2"

Scenario: Test the User show feature
    Given I am logged in with Google 
    When I hover over Profile
    When I follow "Profile"
    Then I should be redirected to the user page
    Then I should see "Test User"
    Then I should see "test"

Scenario: Update the user program
    Given I am logged in with Google as an Admin
    Given I am on the users page
    When I follow "Edit User"
    Then I choose user program id
    And I press "Save"
    When I refresh the page 
    Given I am on the users page
    Then I should see "Greece"
