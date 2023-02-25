Feature: Allow users to post multiple images
    As a user,
    If I have a lot of photos I want to share,
    I want to post multiple images for each experience.

Scenario: Test for uploading multiple images
    Given I am on the add review page
    Then I should be able to upload multiple photos
    
Scenario: Test for posting multiple images
    Given I am on the add review page
    And I uploaded multiple photos
    Then I should see multiple photos in the posted experience