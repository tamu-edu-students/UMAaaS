Feature: Add Bookmark on Reviews
    As a user 
    So that I can remember interesting locations or reviews
    I want to be able to bookmark posts.

Scenario: Test for checking bookmark icon
    Given I am on the singapore page
    Then I should see class "bookmark-experience"

Scenario: Test for checking if bookmarks page exists
    Given I am on the bookmarks page
    Then I should see class "bookmarks-list"

Scenario: Test for viewing bookmark tab under profile
    Given I am logged in with Google
    When I hover over Profile
    Then I should see "Bookmark"

Scenario: Test for viewing all of your saved bookmarks
    Given I am logged in with Google
    When I hover over Profile
    When I follow "Bookmark"
    Then I should see class "bookmarks-list"

Scenario: Bookmark an experience and see if the bookmark is present in the bookmarks page
    Given I am logged in with Google
    Given I am on the singapore page
    Then the experience should not be bookmarked
    When I click on "bookmark-icon"
    Then the experience should be bookmarked

