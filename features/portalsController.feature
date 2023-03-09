Feature: Login
  
Scenario: Test for already logged in
Given I am on the home page
And I am logged in
Given I have a program_id
Then I should see "Experiences"





