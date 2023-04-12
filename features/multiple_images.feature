Feature: Allow users to post multiple images
    As a user,
    I want to be able to upload multiple images
    So that I can showcase my experience in a visual way

Scenario: Test for when user uploads multiple images
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link 
    When I select multiple images to upload
    And I click the "upload" button
    Then I should see a success message
    And I should see the uploaded images on the index page

Scenario: User uploads no images
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link
    When I do not select any images to upload
    And I click on the upload button
    Then I should see an error message

Scenario: User uploads an invalid file type
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link
    When I select an invalid file type to upload
    And I click on the upload button
    Then I should see an error message
