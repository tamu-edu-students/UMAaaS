Feature: Add Bookmark on Reviews
    As a user 
    So that I can remember interesting locations or reviews
    I want to be able to bookmark posts.

Scenario: Test for checking bookmark icon
    Given I am on the singapore page
    Then I should see class "bookmark-experience .bookmark-yes"

Scenario: Test for bookmarking an experience
    Given I am on the singapore page
    # Not working as expected yet
    Then I click on bookmark icon
    # Then I should see class "bookmark-experience .bookmark-yes"
    # Then I should see class "bookmark-experience .bookmarked"
    

Scenario: Test for viewing bookmark tab under profile
    Given I am on the singapore page
    # Element outside of protals controller (Application)
    And I hover over the profile drop down 
    Then I should see "Bookmark"
   
Scenario: Test for viewing all of your saved bookmarks
    Given that I am on any page
    And I click the Bookmarks tab in the profile drop down menu
    Then I should see class "bookmark-experience"

Scenario: Test for viewing the original post of a bookmark
    Given that I am on the Bookmarks page
    And I select a bookmarked experience
    Then I should see class "bookmark-experience" 