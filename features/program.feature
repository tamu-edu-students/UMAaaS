Feature: Program features

Scenario: Choose a program from main page
    Then If I am on the home page
    Then I choose a program_id
    Then I should be redirected to the Greece page

Scenario: Switch the program to another
    Given I am logged in with Google
    Given I am on the singapore page
    Then I switch programs
    Then I should be redirected to the Greece page 

Scenario: Edit the Program
    Given I am logged in with Google as an Admin
    Given I am on the singapore page
    When I hover over Admin
    When I follow "Programs"
    Then I should be redirected to the programs page

Scenario: Create a new Program
    Given I am logged in with Google as an Admin
    When I hover over Admin
    When I follow "Programs"
    When I follow "Add new program"
    When I fill in "Program Name" with "Test Program"
    When I fill in "Location (city, country)" with "Test, Test"
    When I fill in "Region" with "Test"
    And I press "Save"
    Then I should be redirected to the programs page
    Then I should see "Test Program"

Scenario: Edit a program
    Given I am logged in with Google as an Admin
    Given I am on the programs page
    When I follow "Edit Program"
    When I fill in "Location (city, country)" with "Singapore, Singapore"
    And I press "Save"
    Then I should be redirected to the programs page
    Then I should see "Singapore, Singapore"  

Scenario: Disable a program and then enable
    Given I am logged in with Google as an Admin
    Given I am on the programs page
    Then I should see "Test Delete Program"
    When I follow "Edit Program"
    When I follow "Disable Program"
    Given I am on the singapore page
    Given I am on the programs page
    Then I should not see "Test Delete Program"
    When I check show diabled
    When I follow "Edit Program"
    When I follow "Enable Program"
    Then I should see "Test Delete Program"