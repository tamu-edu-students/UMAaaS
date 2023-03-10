Feature: Allow users to post multiple images
    As a user,
    If I have a lot of photos I want to share,
    I want to post multiple images for each experience.

Scenario: Test for uploading multiple images
    Given I am on the add new experience page
    When I press "Choose File(s)"
    Then I should be able to upload multiple photos
    
Scenario: Test for posting multiple images
    Given I am on the add new experience page
    When I upload multiple photos
    And I press "Save"
    Then I should be redirected to the main program page
    Then I should that all of my images were posted