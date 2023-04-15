Feature: Simple experience features
    As a user
    So that I can share  my experiences
    I want to be able to add/edit experiences

Scenario: Check if Experiences are visible
Given I am logged in with Google
Then I should see "Experiences"

Scenario: Add an experience
    Given I am logged in with Google
    Then I should see "Add Experience"

Scenario: Adding an experience should give all the options
    Given I am logged in with Google
    When I follow "Add Experience"
    Then I should see "Title"
    Then I should see "Experience"
    Then I should see "Image"
    Then I should see "Rating"
    Then I should see "Tags"
    Then I should see "Location"


Scenario: Creating an experience and Delete the experience
    Given I am logged in with Google as an Admin
    When I follow "Add Experience"
    When I fill in "Enter a descriptive title" with "Test Experience 2"
    When I fill in "Describe your experience" with "Test Experience"
    When I fill in "comma separated list of tags" with "testtags"
    When I choose 5 rating
    And I press "Save"
    Then I should be redirected to the singapore page
    Then I should see "Test Experience 2"
    Then I should see "#TESTTAGS"
    When I refresh the page
    When I click on "delete-experience"
    Then I should not see "Test Experience 2"

Scenario: Test Creation and Deletion of comments 
    Given I am logged in with Google as an Admin
    When I click on "comment-experience"
    When I fill in "Leave a comment" with "test comment"
    And I press "Save Comment"
    When I refresh the page
    When I click on "view-comments"
    Then I should see "test comment"
    When I click on "delete-comment-experience"
    When I refresh the page
    Then I should not see "test-comment"

Scenario: Option to Flag an experience is available
    Given I am logged in with Google
    When I click on "Test Experience"
    Then I should see class "portal-experience-flag"

Scenario: Flag and experience and then unflag it 
    Given I am logged in with Google as an Admin
    When I click on "Test Experience"
    When I click on "flag-experience"
    When I refresh the page
    Given I am on the singapore page
    When I follow "Flags"
    Then I should see "Experience"
    Then I should see "test"
    Given I am on the singapore page
    When I click on "Test Experience"
    When I click on "unflag-experience"
    When I refresh the page
    Given I am on the singapore page
    When I follow "Flags"
    Then I should not see "Experience"
    Then I should not see "test"

Scenario: Flag an experience and then Admin deletes the Experience
    Given I am logged in with Google as an Admin
    Then I should see "test"
    When I click on "Test Experience"
    When I click on "flag-experience"
    When I refresh the page
    Given I am on the singapore page
    When I follow "Flags"
    When I click on "remote-delete-experience"
    When I refresh the page
    Given I am on the singapore page
    Then I should not see "test"

Scenario: Flag an experience and then Admin clears the flag 
    Given I am logged in with Google as an Admin
    When I click on "Test Experience"
    When I click on "flag-experience"
    When I refresh the page
    Given I am on the singapore page
    When I follow "Flags"
    Then I should see "test"
    When I click on "clear-flags"
    When I refresh the page
    Then I should not see "test"

Scenario: Test for no tags
Given an experience with no tags
When I ask for the tag array
Then I should get nil

Scenario: Test for , tags
Given an experience with tags=,
When I ask for the tag array
Then I should get nil

