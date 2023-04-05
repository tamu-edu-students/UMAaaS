Feature: Simple experience features
    As a user
    So that I can share  my experiences
    I want to be able to add/edit experiences

@omniauth_test
Scenario: Add an experience
    Given I am logged in with Google
    Then I should see "Add Experience"

@omniauth_test
Scenario: Adding an experience should give all the options
    Given I am logged in with Google
    Given I am assigned a program
    When I follow "Add Experience"
    Then I should see "Title"
    Then I should see "Experience"
    Then I should see "Image"
    Then I should see "Rating"
    Then I should see "Tags"
    Then I shouls see "Location"

Scenario: Test for tags
    Given an experience with tags=,
    When I ask for the tag array
    Then I should get nil

Scenario: Test for tags
    Given an experience with tags "1,2,3"
    When I ask for the tag array
    Then I should get an tag array "2, 3"

