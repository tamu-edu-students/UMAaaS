Feature: Add Bookmark on Reviews
    As a user 
    So that I can remember interesting locations or reviews
    I want to be able to bookmark posts.

Scenario: Test for checking bookmark icon
    Given I am on the singapore page
    Then I should see class "bookmark-experience .bookmark-yes"

Scenario: Test for checking if bookmarks page exists
    Given I am on the bookmarks page
    Then I should see class "bookmarks-list"

@omniauth_test
Scenario: Test for viewing bookmark tab under profile
    Given I am logged in with Google
    When I hover over Profile
    Then I should see "Bookmark"

@omniauth_test  
Scenario: Test for viewing all of your saved bookmarks
    Given I am logged in with Google
    Given I am assigned a program
    When I follow "Bookmark"
    Then I should see class "bookmarks-list"

Scenario: Test for viewing the original post of a bookmark
    Given that I am on the Bookmarks page
    And I select a bookmarked experience
    Then I should see class "bookmark-experience" 
