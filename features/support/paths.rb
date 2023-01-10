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
            root_path
	
	    when /^the emergency\s?page$/
            reviews_emergency_path
        
        when /^the programs\s?page$/
            programs_path 
            
        when /^the review\s?page$/
            leave_review_path
            
        when /^the singapore\s?page$/
            portals_path
            
        when /^the singapore\s?search\s?page$/
            'p/1?search=zzzzzz'
        # Add more mappings here.
        # Here is an example that pulls values out of the Regexp:
        #
        #   when /^(.*)'s profile page$/i
        #     user_profile_path(User.find_by_login($1))

        else
            raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
        end
    end
end

World(NavigationHelpers) 
