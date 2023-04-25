Feature: View all images of a program in a gallery
  As a user
  If I want to see all of the images related to a program,
  I want to view a gallery of images in the gallery tab of the program page.

Scenario: User views gallery tab of a program with multiple images
    Given I am on the singapore page
    Given I am logged in with Google
    When I click on the "Image Gallery" tab
    Then I should see a gallery of images with the title "Gallery for Singapore CSCE Wintermester" and "2 images"
    And I should see all 2 images related to the program

  Scenario: User views gallery tab of a program with no images
    Given I am on the singapore page
    Given I am logged in with Google
    When I click on the "Image Gallery" tab
    Then I should see a message that says "No images found for this program"
    And I should not see any images in the gallery