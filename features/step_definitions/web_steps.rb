# frozen_string_literal: true

# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'selectors'))

require 'capybara/rspec'
require 'rack_session_access'
require 'rack_session_access/capybara'

# module WithinHelpers
#   def with_scope(locator)
#     locator ? within(*selector_for(locator)) { yield } : yield
#   end
# end
# World(WithinHelpers)

# # Single-line step scoper
# When /^(.*) within (.*[^:])$/ do |step, parent|
#   with_scope(parent) { When step }
# end

# # Multi-line step scoper
# When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
#   with_scope(parent) { When "#{step}:", table_or_string }
# end
Before do
  Program.create!(name: 'Singapore CSCE Wintermester', region: 'Asia')
  Program.create!(name: 'Greece CSCE Wintermester', region: 'Europe')
  Program.create!(name: 'Test Delete Program', region: 'Test')
  singapore = Program.find_or_create_by(name: 'Singapore CSCE Wintermester')
  User.create!(admin: true, program: singapore, id: 1, img: 'https://picsum.photos/200/300/?random', name: 'Test User',
             email: 'testuser@gmail.com')
  test_user = User.find_or_create_by(email: 'testuser@gmail.com')
  Participant.create(email: 'testuser@gmail.com', program: singapore)
  Experience.create(title: "test", experience: "test experience", rating: 5, user: test_user, program: singapore)
end

Given(/^(?:|I )am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

#And(/^(?:|I )am logged in/) do
  # page.set_rack_session(:user_id => "4")
  # page.set_rack_session(:user_admin => false)
  # page.set_rack_session(:user_program_id => 1 )
#  visit "/auth/google_oauth2"
#end

Given("I am logged in with Google") do
  # Mock the OmniAuth authentication response
  # Visit the Google OAuth callback URL with the mocked authentication response
  singapore = Program.find_or_create_by(name: 'Singapore CSCE Wintermester')
  test_user = User.find_or_create_by(email: 'testuser@gmail.com')
  page.set_rack_session(:user_admin => false)
  page.set_rack_session(:user_email => 'testuser@gmail.com')
  page.set_rack_session(:user_program_id => singapore.id )
  page.set_rack_session(:user_img => "https://picsum.photos/200/300/?random")
  page.set_rack_session(:user => test_user.id)
  page.visit ('/p/' + singapore.id.to_s)
  
  # Verify that the user is redirected to the dashboard page after successful authentication
end

Given("I am logged in with Google as an Admin") do
  singapore = Program.find_or_create_by(name: 'Singapore CSCE Wintermester')
  test_user = User.find_or_create_by(email: 'testuser@gmail.com')
  page.set_rack_session(:user_admin => true)
  page.set_rack_session(:user_email => 'testuser@gmail.com')
  page.set_rack_session(:user_program_id => singapore.id )
  page.set_rack_session(:user_img => "https://picsum.photos/200/300/?random")
  page.set_rack_session(:user => test_user.id)
  page.visit ('/p/' + singapore.id.to_s)  
end

Then('I choose a program_id') do
  within('#index-search-box')
  select 'Greece CSCE Wintermester', from: 'program_id'
end

Given(/If ^(?:|I )am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

Then("I switch programs") do
  within('#portal-switch-programs-form')
  select 'Greece CSCE Wintermester', from: 'program_id'
end

Then('If I am on the home page') do
  visit root_path
end

# When /^(?:|I )go to (.+)$/ do |page_name|
#   visit path_to(page_name)
# end

When(/^(?:|I )press "([^"]*)"$/) do |button|
  click_button(button)
  if button == "Save Comment"
    page.driver.browser.switch_to.alert.accept
  end
end

When("I check show diabled") do 
  find("#programs-filter-show-disabled").set(true)
end

When(/^(?:|I )follow "([^"]*?)"$/) do |link|
  # Visit the Google OAuth callback URL with the mocked authentication response
  test_participant = Participant.find_or_create_by(email: 'testuser@gmail.com')
  singapore = Program.find_or_create_by(name: 'Singapore CSCE Wintermester')
  test_program = Program.find_or_create_by(name: 'Test Delete Program')
  if link == "Edit Program"
    click_link('Edit', :href => edit_program_path(test_program))
  elsif link == "Remove Participant"
    find("a[href='/programs/#{singapore.id.to_s}/participants/#{test_participant.id.to_s}']").click
  else
    click_link(link)
  end
end

When("I click the {string} link") do |link_text|
  click_link link_text
end

Then(/^(?:|I )should be redirected to (.+)$/) do |page_name|
  expect(page).to have_current_path(path_to(page_name))
#  expect(current_path).to eq(path_to(page_name))
end

Then(/^I should see an external link to maps with text (.+)$/) do |name|
  expect(page).to have_link(name, href: /^http\:\/\/maps.google.com.*$/)
end

Then("I enter text in the search bar") do
  page.find('#search-field').set("test\n")
end

When('I fill in {string} with {string}') do |string, name|
  fill_in(string, with: name)
end

When('I hover over Profile') do
  find('.navigation-user-icon', visible: false).hover
end

When('I hover over Admin') do
  find_link(href: "", title: 'Admin').hover
end

When('I hover over bookmark icon') do
  find('.bookmark-yes').hover
end

When('I choose 5 rating') do 
  find('label[for="experience_rating_5"]').click
end

# When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
#   fill_in(field, :with => value)
# end

# When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
#   fill_in(field, :with => value)
# end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
# When /^(?:|I )fill in the following:$/ do |fields|
#   fields.rows_hash.each do |name, value|
#     When %{I fill in "#{name}" with "#{value}"}
#   end
# end

# When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
#   select(value, :from => field)
# end

# When /^(?:|I )check "([^"]*)"$/ do |field|
#   check(field)
# end

# When /^(?:|I )uncheck "([^"]*)"$/ do |field|
#   uncheck(field)
# end

Given(/^an experience with no tags/) do
  @experience1 = Experience.new(program: nil, user: nil, tags: nil)
end

Given(/^an experience with tags=,/) do
  @experience1 = Experience.new(program: nil, user: nil, tags: ',')
end

Given(/^an experience with tags "([^"]*)"$/) do |stringVal|
  @experience1 = Experience.new(program: nil, user: nil, tags: stringVal)
end


When(/^I ask for the tag array/) do
  @resultVal = @experience1.tagArray
end

Then(/^I should get nil$/) do
  expect(@resultVal.nil?)
end

Then(/^I should get an tag array "([^"]*)"$/) do |array|
  @expected = array.split(',')
  expect(@expected == @resultVal)
end

When(/^(?:|I )choose "([^"]*)"$/) do |field|
  choose(field)
end

When(/^(?:|I )click on "([^"]*)"$/) do |icon|
  tip = Tip.find_by(tip: 'Test Tip')
  experience_1 = Experience.find_by(title: 'test')
  experience_2 = Experience.find_by(title: 'Test Experience 2')
  experience_comment = ExperienceComment.find_by(comment: 'test comment')
  if icon == "delete-tip"
    page.find(id: 'portal-tip-delete-' + tip.id.to_s).click
    page.driver.browser.switch_to.alert.accept
  elsif icon == "helpful"
    page.find(id: 'tip-upvote-' + tip.id.to_s).click
  elsif icon == "unhelpful"
    page.find(id: 'tip-downvote-' + tip.id.to_s).click
  elsif icon == "delete-experience"
    page.find(id: 'portal-experience-delete-' + experience_2.id.to_s).click
    page.driver.browser.switch_to.alert.accept
  elsif icon == "comment-experience"
    page.find(class: 'portal-experience-leave-comment').click
  elsif icon == "delete-comment-experience"
    page.find(id: 'portal-experience-comment-delete-' + experience_comment.id.to_s).click
    page.driver.browser.switch_to.alert.accept
  elsif icon == "view-comments"
    page.find(class: 'portal-experience-comment-count', visible: false).click
  elsif icon == "bookmark-icon"
    page.find(id: 'experience-bookmark-' + experience_1.id.to_s).click
  elsif icon == "flag"
    page.find(id: 'tip-flag-' + tip.id.to_s).click
  elsif icon == "unflag"
    page.find(id: 'tip-flag-' + tip.id.to_s).click
  elsif icon == "remote-delete-tip"
    click_button("Delete")
    page.driver.browser.switch_to.alert.accept
  end
end

Then("the experience should be bookmarked") do
  experience_1 = Experience.find_by(title: 'test')
  id = '#experience-bookmark-' + experience_1.id.to_s
  expect(page).to have_css(id, text: "1")
end

Then("the experience should not be bookmarked") do
  expect(page).to have_css(".bookmark-yes", text: "0")
end

When('I refresh the page') do
  visit current_path
end

When('I ') do

end
# When /I click on the "(.+)" link/ do |locator|
#   page.click_link locator
# end

Then(/^(?:|I )should see "([^"]*)"$/) do |text|
  using_wait_time 10 do
    page.should have_content(text) if page.respond_to? :should
  end
end

Then(/^(?:|I )should not see "([^"]*)"$/) do |text|
  using_wait_time 10 do
    page.should_not have_content(text) if page.respond_to? :should
  end
end

# Then /^(?:|I )should see a "([^"]*)" card$/ do |text|
#   if page.respond_to? :should
#     page.should have_content(text)
#   else
#     assert page.has_content?(text)
#   end
# end

Then(/^(?:|I )should see class "([^"]*)"$/) do |text|
  page.should have_selector(".#{text}", wait: 100) if page.respond_to? :should
end

# Then /^(?:|I )should not see class "([^"]*)"$/ do |text|
#   if page.respond_to? :should
#     !page.should have_selector('.' + text)
#   else
#     !assert page.have_selector?('.' +text)
#   end
# end

Then(/^(?:|I )should see id "([^"]*)"$/) do |text|
  page.should have_selector("##{text}") if page.respond_to? :should
end

Then (/I click on bookmark icon/) do
  # page.find('.bookmark-experience').click
  puts page.find('#experience-bookmark-1')
  # .click
  # page.should have_selector(".bookmark-experience .bookmarked", wait: 100) if page.respond_to? :should
end


# When('I am on the new page') do
#   visit new_experience_path
# end
# When (/I hover over the profile drop down menu/) do
#   click_link("")
# end

# Then(/I should see "(.*)"/) do |string|
#   expect(page).to have_content(string)
# end

#When(/^I click on bookmark icon/) do 
#  page.driver.browser.execute_script("$(document).off('click', '.bookmark-yes').on('click', '.bookmark-yes')")
#end

# Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
#   regexp = Regexp.new(regexp)
#
#   if page.respond_to? :should
#     page.should have_xpath('//*', :text => regexp)
#   else
#     assert page.has_xpath?('//*', :text => regexp)
#   end
# end

# Then /^(?:|I )should not see "([^"]*)"$/ do |text|
#   if page.respond_to? :should
#     page.should have_no_content(text)
#   else
#     assert page.has_no_content?(text)
#   end
# end

# Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
#   regexp = Regexp.new(regexp)
#
#   if page.respond_to? :should
#     page.should have_no_xpath('//*', :text => regexp)
#   else
#     assert page.has_no_xpath?('//*', :text => regexp)
#   end
# end

# Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
#   with_scope(parent) do
#     field = find_field(field)
#     field_value = (field.tag_name == 'textarea') ? field.text : field.value
#     if field_value.respond_to? :should
#       field_value.should =~ /#{value}/
#     else
#       assert_match(/#{value}/, field_value)
#     end
#   end
# end

# Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
#   with_scope(parent) do
#     field = find_field(field)
#     field_value = (field.tag_name == 'textarea') ? field.text : field.value
#     if field_value.respond_to? :should_not
#       field_value.should_not =~ /#{value}/
#     else
#       assert_no_match(/#{value}/, field_value)
#     end
#   end
# end

# Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
#   element = find_field(field)
#   classes = element.find(:xpath, '..')[:class].split(' ')
#
#   form_for_input = element.find(:xpath, 'ancestor::form[1]')
#   using_formtastic = form_for_input[:class].include?('formtastic')
#   error_class = using_formtastic ? 'error' : 'field_with_errors'
#
#   if classes.respond_to? :should
#     classes.should include(error_class)
#   else
#     assert classes.include?(error_class)
#   end
#
#   if page.respond_to?(:should)
#     if using_formtastic
#       error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
#       error_paragraph.should have_content(error_message)
#     else
#       page.should have_content("#{field.titlecase} #{error_message}")
#     end
#   else
#     if using_formtastic
#       error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
#       assert error_paragraph.has_content?(error_message)
#     else
#       assert page.has_content?("#{field.titlecase} #{error_message}")
#     end
#   end
# end

# Then /^the "([^"]*)" field should have no error$/ do |field|
#   element = find_field(field)
#   classes = element.find(:xpath, '..')[:class].split(' ')
#   if classes.respond_to? :should
#     classes.should_not include('field_with_errors')
#     classes.should_not include('error')
#   else
#     assert !classes.include?('field_with_errors')
#     assert !classes.include?('error')
#   end
# end

# Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
#   with_scope(parent) do
#     field_checked = find_field(label)['checked']
#     if field_checked.respond_to? :should
#       field_checked.should be_true
#     else
#       assert field_checked
#     end
#   end
# end

# Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
#   with_scope(parent) do
#     field_checked = find_field(label)['checked']
#     if field_checked.respond_to? :should
#       field_checked.should be_false
#     else
#       assert !field_checked
#     end
#   end
# end

# Then /^(?:|I )should be on (.+)$/ do |page_name|
#   current_path = URI.parse(current_url).path
#   if current_path.respond_to? :should
#     current_path.should == path_to(page_name)
#   else
#     assert_equal path_to(page_name), current_path
#   end
# end

# Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
#   query = URI.parse(current_url).query
#   actual_params = query ? CGI.parse(query) : {}
#   expected_params = {}
#   expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}
#
#   if actual_params.respond_to? :should
#     actual_params.should == expected_params
#   else
#     assert_equal expected_params, actual_params
#   end
# end

# Then /^show me the page$/ do
#   save_and_open_page
# end

### Unique to multiple images and gallery features ###
When("I select multiple images to upload") do
  attach_file("images[]", Rails.root.join("spec/fixtures/files/image1.jpg"))
  attach_file("images[]", Rails.root.join("spec/fixtures/files/image2.jpg"))
end

When("I do not select any images to upload") do
  # do nothing
end

When("I select an invalid file type to upload") do
  attach_file("images[]", Rails.root.join("spec/fixtures/files/invalid.txt"))
end

When("I click on the upload button") do
  click_button "Upload"
end

Then("I should see a success message") do
  expect(page).to have_content("Images uploaded successfully.")
end

Then("I should see an error message") do
  expect(page).to have_content("There was an error uploading your images.")
end

Then("I should see the uploaded images on the index page") do
  expect(page).to have_selector("img[src$='image1.jpg']")
  expect(page).to have_selector("img[src$='image2.jpg']")
end
