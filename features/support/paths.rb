# frozen_string_literal: true

# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the emergency\s?page$/
      '/reviews/emergency'

    when /^the programs\s?page$/
      '/programs/index'

    when /^the review\s?page$/
      'reviews/leave_review/os-fZ4atEmOxbIo36kG9gA'

    when /^the show_mad_taco\s?page$/
      'reviews/os-fZ4atEmOxbIo36kG9gA'

    when /^the singapore\s?page$/
      'p/1'

    when /^the singapore\s?search\s?page$/
      'p/1?search=zzzzzz'
  
    when /^the new\s?page$/
      'p/2/experiences/new'

    when /^the edit\s?page$/
      'experience/2/edit'

    when /^the experience\s?page$/
      'experience/2'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" \
            "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
