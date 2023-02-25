Feature: Add Bookmark on Reviews
    As a user 
    So that I can remember interesting locations or reviews
    I want to be able to bookmark posts.

Scenario: Test for bookmarking experience
    Given that I am viewing an experience
    And I want to save that experience
    Then I should be able to click on the bookmark icon 
    Then it should save the experience under my user profile. 
    
Scenario: Test for viewing bookmark tab under profile
    Given that I am on any page
    And I click on the profile drop down menu
    Then I should see "bookmarks"
   
Scenario: Test for viewing all of your saved bookmarks
    Given that I am on any page
    And I click the Bookmarks tab in the profile drop down menu
    Then I should see "bookmarks_page"

Scenario: Test for viewing the original post of a bookmark
    Given that I am on the Bookmarks page
    And I select a bookmarked experience
    Then I should see "experience" 