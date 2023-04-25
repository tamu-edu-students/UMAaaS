Feature: Simple experience features
    As a user
    So that I can share any tips
    I want to be able to add/delete Tips
 
Scenario: Check if Experiences are visible
Given I am logged in with Google
Given I am on the singapore page
Then I should see "Tips"

Scenario: Option to Add a Tip
    Given I am logged in with Google
    Then I should see "Add Tip"

Scenario: Adding a Tip should give all the options
    Given I am logged in with Google
    When I follow "Add Tip"  
    Then I should see "Tip"

Scenario: Add a Tip and then delete it
    Given I am logged in with Google
    When I follow "Add Tip"
    When I fill in "Tip" with "Test Tip"
    And I press "Save"
    Then I should be redirected to the singapore page
    Then I should see "Test Tip"
    When I click on "delete-tip"
    Then I should not see "Test Tip"

Scenario: Add a tip and then mark helpful/unhelpful
    Given I am logged in with Google
    When I follow "Add Tip"
    When I fill in "Tip" with "Test Tip"
    And I press "Save"
    Then I should be redirected to the singapore page
    When I click on "helpful"
    When I click on "unhelpful"

Scenario: Flag a tip and then unflag it
    Given I am logged in with Google as an Admin
    When I follow "Add Tip"
    When I fill in "Tip" with "Test Tip"
    And I press "Save"
    When I click on "flag"
    When I follow "Flags"
    Then I should see "Test Tip"
    Given I am on the singapore page
    When I click on "unflag"
    When I follow "Flags"
    Then I should not see "Test Tip"

Scenario: Flag a tip and then Admin deletes it
    Given I am logged in with Google as an Admin
    When I follow "Add Tip"
    When I fill in "Tip" with "Test Tip"
    And I press "Save"
    When I click on "flag"
    When I follow "Flags"
    When I click on "remote-delete-tip"
    Given I am on the singapore page
    Then I should not see "Test Tip"

Scenario: Flag a tip and then Admin clears the flag
    Given I am logged in with Google as an Admin
    When I follow "Add Tip"
    When I fill in "Tip" with "Test Tip"
    And I press "Save"
    When I click on "flag"
    When I follow "Flags"
    Then I should see "Test Tip"
    When I click on "clear-flags"
    When I refresh the page
    Then I should not see "Test Tip"
    
