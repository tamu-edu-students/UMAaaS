class PortalsController < ApplicationController

    def index
        @programs = Program.where(disabled: false)
        print("ON PROGRAM PAGE\n")
        print("Logged in: ",logged_in?)
        if logged_in?
            #if logged in and the user already has a program selected, then automatically go that program portal
            print("Portal ID:", current_user.user_program_id)
            program = Program.find current_user.user_program_id unless current_user.user_program_id.nil?
            if(not program.nil?) then
                redirect_to portal_path(program.id)
            end
        end
    end
    
    def program_select
        print("RUNNING PROGRAM SELECT")
        program = Program.find params[:program_id]
        
        # if(program.nil?) then
        #     flash[:notice] = "Pogram not found!"
        # else
            if logged_in?
                #save selected program to the user account so next time they don't have to select it
                user = User.find current_user.id
                if(not user.nil?) then
                    user.program_id = program.id
                    user.save
                    current_user.user_program_id = program.id
                end
            end
            redirect_to portal_path(program.id)
        end
    # end
    
    
    def program_view
        program = Program.find params[:program_id]
        if(program.nil?) then
            flash[:notice] = "Pogram not found!"
        else
            current_user.user_program_id = program.id
            redirect_to portal_path(program.id)
        end
    end
    
    def view
        #get this specific program
        puts "HEYYYYY"
        @program = Program.find params[:id]
        
        # get list of all programs to display in drop down list for switching between
        @programs = Program.where(disabled: false)
        puts "HALLO"
        
        
        # get the search terms, if the search starts with "tag: ", then only search tags
        searchTerm = nil
        searchTagsOnly = nil
        if not params[:search].blank?
            match = params[:search].match(/\Atag:\s*([0-9a-z -]+)/i)
            if not match.nil?
                searchTerm = match[1]
                searchTagsOnly = true
            else
                searchTerm = params[:search]
            end
        end
        

        if searchTagsOnly.nil?  # Tips don't have tags, so if we're only searching tags then we can skip the tips
            
            # get all tips for this program
            @tips = Tip.left_outer_joins(:user).select("tips.*,users.name as user_name").where(tips: {program_id: params[:id]})
    
            searchResults = Array.new
    
            @tips.each do |tip|
                found = true
                if not searchTerm.nil?
                    found = false
                    if(tip.tip =~ /#{searchTerm}/i)
                        found = true
                    end
                end
            
                upvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: tip.id).where(users: {banned: false}).where(vote: 1).group(:tip_id).count(:vote).values[0]
                if upvote_sum.blank? 
                    upvote_sum = 0
                end                 
                tip.upvoteCount = upvote_sum
                
                downvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: tip.id).where(users: {banned: false}).where(vote: -1).group(:tip_id).count(:vote).values[0]
                if downvote_sum.blank? 
                    downvote_sum = 0
                end 
                tip.downvoteCount = downvote_sum
                
                tip.hasUserUpvoted = 0
                tip.hasUserDownvoted = 0
                helpful = HelpfulVote.select("vote").where(tip_id: tip.id).where(user_id: current_user.id).first
                if not helpful.nil?
                    if helpful.vote == 1
                        tip.hasUserUpvoted = 1
                    elsif helpful.vote == -1
                        tip.hasUserDownvoted = 1
                    end
                end
                
                if found
                    searchResults.push(tip) # only records matching the search term, if there is one, will be added to searchResults
                end
            end
            
            @tips = searchResults  # put searchResults back into @tips for the view to use
        else
            @tips = []
        end
        
        
        # get all experiences for this program
        @experiences = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {program_id: params[:id]}).where(users: {banned: false}).order(rating: :desc)
        

        searchResults = Array.new
        
        # for each experience get the comments associated with it and calculate the average rating
        @experiences.each do |exp|
            found = true
            if not searchTagsOnly.nil?
                found = false
                if(exp.tags =~ /,#{searchTerm},/i)
                    found = true
                end
            elsif not searchTerm.nil?
                found = false
                if((exp.experience =~ /#{searchTerm}/i) or (exp.yelp_name =~ /#{searchTerm}/i) or (exp.tags =~ /#{searchTerm}/i))
                    found = true
                end
            end
            
            exp.tagArray

            exp.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: exp.id).where(users: {banned: false}).order(created_at: :desc).limit(Rails.configuration.max_comments_shown)
            
            exp.totalComments = ExperienceComment.left_outer_joins(:user).where(experience_id: exp.id).where(users: {banned: false}).count(:id)
            
            if searchTagsOnly.nil? and not searchTerm.nil?
                searchComments = exp.comments.where('comment LIKE ?', "%#{searchTerm}%")
                if searchComments.size > 0
                    found = true
                end
            end
            
            rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: exp.id).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
            if(rating_sum.nil?)
                rating_sum = exp.rating #just the original rating
            else
                rating_sum += exp.rating #add the original rating
            end
            rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: exp.id).where(users: {banned: false}).where.not(rating: nil).count(:id)
            rating_count +=1 #add 1 for the original rating
            exp.average_rating = (rating_sum.to_f / rating_count).round(1)
            
            if found
                searchResults.push(exp) # only records matching the search term, if there is one, will be added to searchResults
            end
        end
        
        @experiences = searchResults  # put searchResults back into @experiences for the view to use
        
        # for sorting the experiences
        if(params[:sort_exp].nil?) then
            @experience_sort_by = "rating"
        else
            @experience_sort_by = params[:sort_exp]
        end
        
        #already sorted by rating by default, so only need to sort if some else is selected
        if(@experience_sort_by == "avg_rating") then
            @experiences = @experiences.sort_by(&:average_rating).reverse!
        elsif(@experience_sort_by == "rating_asc") then
            @experiences = @experiences.sort_by(&:rating);
        elsif(@experience_sort_by == "avg_rating_asc") then
            @experiences = @experiences.sort_by(&:average_rating);
        elsif(@experience_sort_by == "date") then
            @experiences = @experiences.sort_by(&:created_at).reverse!
        elsif(@experience_sort_by == "comments") then
            @experiences = @experiences.sort_by {|x| x.totalComments}.reverse!
        end
        
        
        # for sorting the tips
        if(params[:sort_tip].nil?) then
            @tip_sort_by = "helpful"
        else
            @tip_sort_by = params[:sort_tip]
        end
              
        #already sorted by helpful by default, so only need to sort if some else is selected
        if(@tip_sort_by == "helpful") then
            @tips = @tips.sort_by {|x| x.upvoteCount - x.downvoteCount}.reverse!
        elsif(@tip_sort_by == "date") then
            @tips = @tips.sort_by(&:created_at).reverse!
        end                

    end
end