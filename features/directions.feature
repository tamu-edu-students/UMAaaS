Feature: Get Directions to Experience on Map
    As a user,
    So that I can locate specific attractions,
    I want to use a map tool to find it.

Scenario: Test for Add Location of an Experience
  Given I am on the add new experience page
  When I press "Add Location"
  Then I should see a map
  Then I should be able to select the location
  
Scenario: Test for View location on map
  Given I am on an experience page
  And I see that a location was added
  Then I should see a map
 
Scenario: Test for Redirect to Google Maps
  Given I am on an experience page
  When I click on the map
  Then I should be redirected to an external Google Maps page
  