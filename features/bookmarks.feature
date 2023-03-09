Feature: Add Bookmark on Reviews
    As a user 
    So that I can remember interesting locations or reviews
    I want to be able to bookmark posts.

Scenario: Test for checking bookmark icon
    Given I am on the singapore page
    Then I should see class "bookmark-experience"

Scenario: Test for bookmarking an experience
    Given I am on the singapore page
    When I click on bookmark icon 
    Then I should see class "bookmarked"
    
Scenario: Test for viewing bookmark tab under profile
    Given I am on the singapore page
    And I am logged in
    And I click on the profile drop down menu
    Then I should see class "bookmark-experience"
   
Scenario: Test for viewing all of your saved bookmarks
    Given that I am on any page
    And I click the Bookmarks tab in the profile drop down menu
    Then I should se class "bookmark-experience"

Scenario: Test for viewing the original post of a bookmark
    Given that I am on the Bookmarks page
    And I select a bookmarked experience
    Then I should see class "bookmark-experience" 