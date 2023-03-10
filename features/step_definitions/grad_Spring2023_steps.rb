# For the Spring 2023 Graduate team
# To have a single place for all of the steps we write

###################
# Bookmarks 
When /I click on "(.+)"/ do |button|
    click_on(button)
end

When /I select "(.+)"/ do |action|
    click_on(button)
end

###################
# Multiple Images (mult_images)

# Given /I am on the add new experience page/ do 
#     visit (new_experience_path)
# end
When /I press "Choose File(s)"/ do |choose|
    click_on(choose)
end

Then /I should be able to upload multiple photos/ do |something|
# I am not sure what to do for this one
end


When /I upload multiple photos/ do |something|
    # also not sure what to do for this one
end

When /I press "Save"/ do 
    save_page  # is this right?
end

Then /I should be redirected to the main program page/ do 
    visit(program_view_path) # check that this is the right path
end

Then /I should see "(.+)"/ do |images|
    expect(page).to have_content(images)
end

###################

# Directions to Experience on Map (directions)
Then /I should be able to select the location/ do |something|
    # TODO
end


When /I see that a location was added/ do
    # TODO
end

Then /I should be redirected to an external Google Maps page/ do
    # TODO
end

###################

# Random image for landing page (rand_img_landing)
