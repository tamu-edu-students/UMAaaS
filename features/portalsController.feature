Feature: Login
  
Scenario: Test for already logged in
Given I am on the home page
And I am logged in
And I have a program_id
Then I should see "Experiences"

# Scenario: Already logged in and have a program

Given I am logged in
And I have a program_id
Then If I am on the home page
Then I should see "Experiences"




