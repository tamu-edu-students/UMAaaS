Feature: Get Directions to Experience on Map
    As a user,
    So that I can locate specific attractions,
    I want to use a map tool to find it.
   
Scenario: Test for add location for new page
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link 
    Then I should be redirected to the new page
    Then I should see "Location"
      
Scenario: Test for add location
    Given I am logged in with Google
    Given I am on the edit page
    Then I should see "Location"

Scenario: fill for add location
    Given I am logged in with Google
    Given I am on the edit page
    Then I should see "Location"
    When I fill in "Place Name" with "KFC"
    And I press "Save"
    Then I should be redirected to the experience page
    Then I should see "KFC"
    
Scenario: redirect to google map
    Given I am logged in with Google
    Given I am on the edit page
    Then I should see "Location"
    When I fill in "Place Name" with "Mcdonold"
    And I press "Save"
    Then I should be redirected to the experience page
    Then I should see "Mcdonold"
    Then I should see an external link to maps with text Mcdonold
    