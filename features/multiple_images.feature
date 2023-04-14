Feature: Allow users to post multiple images
    As a user,
    I want to be able to upload multiple images
    So that I can showcase my experience in a visual way

Scenario: Test for when user uploads multiple images
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link 
    And I select multiple images to upload
    And I press "Save"
    Then I should see the uploaded images on the index page

Scenario: User uploads no images
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link
    And I do not select any images to upload
    Then I should not see the uploaded images on the index page

Scenario: User uploads an invalid file type
    Given I am on the singapore page
    Given I am logged in with Google
    When I click the "Add Experience" link
    And I select an invalid file type to upload
    And I press "Save"
    # Then I should see the "warning" flash message with "Invalid file format. Only JPEG, PNG, and GIF images are allowed."
