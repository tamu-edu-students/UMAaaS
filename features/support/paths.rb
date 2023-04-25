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
    singapore = Program.find_or_create_by(name: 'Singapore CSCE Wintermester')
    greece = Program.find_or_create_by(name: 'Greece CSCE Wintermester')
    test_user = User.find_or_create_by(email: 'testuser@gmail.com')
    experience = Experience.find_by(program_id: singapore.id, user_id: test_user.id)
    case page_name

    when /^the test search\s?page$/
      '/p/' + singapore.id.to_s + '?search=test&z.x=0&z.y=0'

    when /^the home\s?page$/
      '/'

    when /^the emergency\s?page$/
      '/reviews/emergency'

    when /^the programs\s?page$/
      '/programs'

    when /^the singapore\s?page$/
      "/p/" + singapore.id.to_s

    when /^the Greece\s?page$/
      "/p/" + greece.id.to_s

    when /^the new\s?page$/
      '/p/' + singapore.id.to_s + '/experiences/new'

    when /^the edit\s?page$/
      '/experience/' + experience.id.to_s + '/edit'

    when /^the experience\s?page$/
      '/experience/' + experience.id.to_s

    when /^the user\s?page$/
      '/users/' + test_user.id.to_s + '/edit'

    when /^the ban_comment\s?page$/
      '/users/' + test_user.id.to_s + '/ban_comment'

    when /^the bookmarks\s?page$/
      '/experience/bookmarks/' + test_user.id.to_s
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /^the Add new participants on Greece\s?page$/
      '/programs/' + greece.id.to_s + '/participants/new'

    when /^the Add new participants on Singapore\s?page$/
      '/programs/' + singapore.id.to_s + '/participants/new'
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" \
            "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
