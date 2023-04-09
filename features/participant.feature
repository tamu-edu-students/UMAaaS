Feature: Add/Manage Participants
As an admin
So that I can manage participants for programs
I should be able to add/edit/manage participants. 

@omniauth_test
Scenario: Add a Participant
    Given I am logged in with Google as an Admin
    Then I should see "Participants"

@omniauth_test
Scenario: Adding a participant should give all the options
    Given I am logged in with Google as an Admin
    When I follow "Participants"
    Then I should see "Participant Email"
    Then I should see "Faculty"
    Then I should see "Email"
    Then I should see "Faculty"
    Then I should see "Remove"

@omniauth_test
Scenario: Addng a participant
    Given I am logged in with Google as an Admin
    Given I am on the Greece page
    When I follow "Participants"
    When I fill in "Participant Email" with "testuser@gmail.com"
    And I press "Save"
    Then I should be redirected to the Add new participants on Greece page
    Given I am on the Greece page
    Then I should see "Add Experience"

@omniauth_test
Scenario: Removing a participant
    Given I am logged in with Google as an Admin
    Given I am on the singapore page
    When I follow "Participants"
    Then I should see "testuser@gmail.com"
    When I follow "Remove Participant"
    Given I am on the Add new participants on Singapore page
    Then I should not see "testuser@gmail.com"