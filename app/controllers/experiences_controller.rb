class ExperiencesController < ApplicationController

    # before_action :checkPrivilege
    
    # def checkPrivilege
    #     participant = Participant.find_by(email: current_user.email, program_id: params[:id])
    #     if participant.nil?
    #         flash[:alert] = "You are not assigned to this program."
    #         redirect_to portal_path(params[:id]) and return 
    #     end
    # end

    def new
        @program = Program.find params[:id]
        @experience = Experience.new
        program = Program.find params[:id]
        program_id = params[:id] 
        participant = Participant.find_by(email: current_user.email, program_id: params[:id])
        if participant.nil? and not current_user.admin
            puts "FOUND NIL"
            flash[:warning] = "You are not assigned to this program."
            redirect_to portal_path(program_id) and return 
        end
        @near = program.location
    end
    
    def create
        params.require(:experience).permit(:title, :experience, :rating, :tags, :location, :street, :city, :postal_code, {images: []})
        if(params[:experience][:experience].blank? || params[:experience][:rating].blank?) # experience and rating are required
            flash[:notice] = "Cannot create experience"
            redirect_to portal_path(params[:id]) and return
        end
        
        
        tagArray = params[:experience][:tags].split(",")
        tagArrayFixed = ","   # list of tags in database will begin and end with a comma, and no spaces around the commas
        tagArray.each do |tag|
            tag = tag.strip.upcase
            tagArrayFixed += tag + ","
        end
        
        newExperience = Experience.create(:title => params[:experience][:title], :experience => params[:experience][:experience], :rating => params[:experience][:rating], :tags => tagArrayFixed, :user_id => current_user.id, :program_id => params[:id], :location => params[:experience][:location], :street => params[:experience][:street], :city => params[:experience][:city], :postal_code => params[:experience][:postal_code])
        
        
   
        images = params[:images]
        valid_formats = ["image/jpeg", "image/png", "image/gif"]
        
        images.each do |image|
            unless valid_formats.include? image.content_type
                flash[:warning] = "Invalid file format. Only JPEG, PNG, and GIF images are allowed."
                redirect_to portal_path(params[:id]) and return
            end
        end

        if params[:images]
            newExperience.images.attach(params[:images])
        end
        
        flash[:notice] = "Experience was successfully created."
     

        # if(params.has_key?(:yelp_id))
        #     # has a Yelp location selected
        #     YelpLocation.create(:experience_id => newExperience.id, :name => params[:yelp_name], :address => params[:yelp_address], :alias => params[:yelp_alias], :yelp_id => params[:yelp_id], :url => params[:yelp_url], :image_url => params[:yelp_image_url], :rating => params[:yelp_rating], :yelp_tags => params[:yelp_tags])
        # end
        
        redirect_to portal_path(params[:id])
    end
    
    
    def view
        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {id: params[:id]}).first
        
        puts "VIEWING!"
        #@experience = Experience.left_outer_joins(:user).all.where(experiences: {id: params[:id]}).where(users: {banned: false}).first
        participant = Participant.find_by(email: current_user.email, program_id: @experience.program_id)
        if participant.nil? and not current_user.admin
            puts "FOUND NIL"
            flash[:warning] = "You are not assigned to this program."
            redirect_to portal_path(@experience.program_id) and return 
        end
        
        @experience.commented = false
        comment = ExperienceComment.where.not(rating: nil).find_by(user_id: current_user.id, experience_id: @experience.id)
        if !comment.nil?
            puts "commented true"
            @experience.commented = true
        else 
            puts "commented false"
        end

        @program = Program.find @experience.program_id
        
        @experience.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: params[:id]).where(users: {banned: false}).order(created_at: :desc)
        
        @experience.totalComments = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:id]).where(users: {banned: false}).count(:id)
        
        rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:id]).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
        if(rating_sum.nil?)
            rating_sum = @experience.rating #just the original rating
        else
            rating_sum += @experience.rating #add the original rating
        end
        rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:id]).where(users: {banned: false}).where.not(rating: nil).count(:id)
        rating_count +=1 #add 1 for the original rating
        @experience.average_rating = (rating_sum.to_f / rating_count).round(1)
        @experience.hasUserBookmarked = 0
        bookmarked = Bookmark.select("bookmarked").where(experience_id: @experience.id).where(user_id: current_user.id).first
        if not bookmarked.nil?
            if bookmarked.bookmarked == 1
                @experience.hasUserBookmarked = 1
            end
        end
        
        
        flag_sum = FlagExperience.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).where(flag: 1).group(:experience_id).count(:flag).values[0]
        if flag_sum.blank? 
            flag_sum = 0
        end                 
        @experience.flagCount = flag_sum
        puts(@experience.flagCount)

        @experience.hasUserFlagged = 0
        flagged = FlagExperience.select("flag").where(experience_id: @experience.id).where(user_id: current_user.id).first
        if not flagged.nil?
            if flagged.flag == 1
                @experience.hasUserFlagged = 1
            end
        end
    end
    
    
    def bookmark_view
      @user = User.find params[:id]
      @bookmarks = Bookmark.left_outer_joins(:user).select("bookmarks.*").where(users: { id: params[:id]})
      @experiences = Array.new
      @bookmarks.each do |item|
        @experiences.append(Experience.find(item.experience_id))
      end
    end

    def create_comment
        # participant = Participant.find_by(email: current_user.email, program_id: @experience.program_id)
        # if participant.nil? and not current_user.admin
        #     puts "FOUND NIL"
        #     flash[:alert] = "You are not assigned to this program."
        #     redirect_to portal_path(program_id) and return 
        # end
        
        ExperienceComment.create(:comment => params[:commentText], :rating => params[:rating], :user_id => current_user.id, :experience_id => params[:experienceId])
        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {id: params[:experienceId]}).first
        
        @experience.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: params[:experienceId]).where(users: {banned: false}).order(created_at: :desc).limit(Rails.configuration.max_comments_shown)
        
        @experience.totalComments = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:id]).where(users: {banned: false}).count(:id)
        
        rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:experienceId]).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
        rating_sum += @experience.rating #add the original rating
        rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:experienceId]).where(users: {banned: false}).where.not(rating: nil).count(:id)
        rating_count +=1 #add 1 for the original rating
        @experience.average_rating = (rating_sum.to_f / rating_count).round(1)
        @experience.commented = true
        
        @experienceDivId = "portal-experience-wrapper-" + params[:experienceId]
        
        respond_to do |format|
            format.js {}  # code in views/experiences/create_comment.js.erb will return
        end
    end
    
    def flagged 
        puts("STARTED FLAGGING")
        puts(params)
        if(params[:flag] == "0")
            
            # puts "destroying flag"
            FlagExperience.where(experience_id: params[:expId]).where(user_id: current_user.id).destroy_all
        else 
            # puts "params of flag" + params[:flag].to_s
            FlagExperience.create(:flag => params[:flag], :user_id => current_user.id, :experience_id => params[:expId])
        end
        
        @experience = Experience.left_outer_joins(:user).select("experiences.*,users.name as user_name").where(experiences: {id: params[:expId]}).first
        
        # str = "number of experience: " 
        # puts str + @experience.to_s 

        flag_sum = FlagExperience.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).where(flag: 1).group(:experience_id).count(:flag).values[0]
        if flag_sum.blank? 
            flag_sum = 0
        end                 
        @experience.flagCount = flag_sum

        @experience.hasUserFlagged = 0
        flagged = FlagExperience.select("flag").where(experience_id: @experience.id).where(user_id: current_user.id).first
        if not flagged.nil?
            if flagged.flag == 1
                @experience.hasUserFlagged = 1
            end
        end
        
        @experienceDivId = "portal-experience-wrapper-" + params[:expId]
        
        
        respond_to do |format|
            format.js {}
        end
    end
    
    def unflag
        FlagExperience.where(experience_id: params[:id]).destroy_all
        respond_to do |format|
          format.html { redirect_to request.referer, notice: 'All flags cleared from experience.' }
        end
    end

    # deletes a whole experience
    def delete
        # prevent unauthorized deletions
        if(not logged_in? or not current_user.admin)
           flash[:warning] = "You are not authorized to delete this post!"
           redirect_to root_path and return 
        end
        
        experience = Experience.find params[:id]
        
        if(experience.nil?)
            flash[:alert] = "Post not found, error deleting!"
            redirect_to root_path and return
        elsif((experience.user_id != current_user.id) && (not current_user.admin))
            flash[:warning] = "You are not authorized to delete this post!"
            redirect_to root_path and return
        end
        # done checking for unauthorized deletions
        
        # delete flag
        FlagExperience.where(experience_id: params[:id]).destroy_all
        
        # delete comments
        ExperienceComment.where(experience_id: params[:id]).destroy_all
        
        # delete associated location
        YelpLocation.where(experience_id: params[:id]).destroy_all
        
        # delete experience
        Experience.where(id: params[:id]).destroy_all
        

        redirect_to root_path and return 
        
        # respond_to do |format|
        #     format.html { redirect_to request.referer, notice: 'Experience was successfully deleted.' }
        # end
    end
    
    def remoteDelete
        experience = Experience.find params[:id]
        
        # delete flag
        FlagExperience.where(experience_id: params[:id]).destroy_all
        
        # delete comments
        ExperienceComment.where(experience_id: params[:id]).destroy_all
        
        # delete associated location
        YelpLocation.where(experience_id: params[:id]).destroy_all
        
        #delete bookmark
        Bookmark.where(experience_id: params[:id]).destroy_all
        
        # delete experience
        Experience.where(id: params[:id]).destroy_all
        
        respond_to do |format|
            format.html { redirect_to request.referer, notice: 'Experience was successfully deleted.' }
        end
    end
    
    # deletes just 1 comment
    def delete_comment
        # prevent unauthorized deletions
         if(not logged_in?)
            flash[:warning] = "You are not authorized to delete this post!"
            redirect_to root_path and return 
         end
        
        experienceComment = ExperienceComment.find params[:id]
    
        if(experienceComment.nil?)
            flash[:warning] = "Post not found, error deleting!"
            redirect_to root_path and return
        elsif((experienceComment.user_id != current_user.id) && (not current_user.admin))
            flash[:warning] = "You are not authorized to delete this post!"
            redirect_to root_path and return
        end
        # done checking for unauthorized deletions
        


        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {id: experienceComment.experience_id}).first

        experienceComment.destroy
        
        @experience.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: @experience.id).where(users: {banned: false}).order(created_at: :desc)
        
        @experience.totalComments = ExperienceComment.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).count(:id)
        
        rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
        if(rating_sum.nil?)
            rating_sum = 0
        end
        rating_sum += @experience.rating #add the original rating
        rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).where.not(rating: nil).count(:id)
        rating_count +=1 #add 1 for the original rating
        @experience.average_rating = (rating_sum.to_f / rating_count).round(1)
        
        @experienceDivId = "portal-experience-wrapper-" + @experience.id.to_s
        
        @experience.commented = false
        comment = ExperienceComment.where.not(rating: nil).find_by(user_id: current_user.id, experience_id: @experience.id)
        if !comment.nil?
            puts "commented true"
            @experience.commented = true
        else 
            puts "commented false"
        end

        respond_to do |format|
            format.js {}   # code in views/experiences/delete_comment.js.erb will return
        end
    end
    
    
    def edit
        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.yelp_id as yelp_id, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating, yelp_locations.yelp_tags as yelp_tags").where(experiences: {id: params[:id]}).first
        program = Program.find @experience.program_id
        @near = program.location
        
        
        @experience.tags = @experience.tags[1..-2] unless @experience.tags.nil? #tags are stored with a leading & trailing comma, this strips those off
    end
    
    
    def update
        if(params[:commit] == "Cancel")   #if the user pressed the cancel button then just go back to the previous page
            redirect_to experience_path(params[:id]) and return
        end
        
        if(params[:experience][:title].blank? || params[:experience][:experience].blank? || params[:experience][:rating].blank?) # experience and rating are required
            flash[:alert] = "Cannot update experience"
            redirect_to experience_path(params[:id]) and return
        end
        
        tagArray = params[:experience][:tags].split(",")
        tagArrayFixed = ","   # list of tags in database will begin and end with a comma, and no spaces around the commas
        tagArray.each do |tag|
            tag = tag.strip.upcase
            tagArrayFixed += tag + ","
        end

        @experience = Experience.find params[:id]
        @experience.update_attributes(:title => params[:experience][:title], :experience => params[:experience][:experience], :rating => params[:experience][:rating], :tags => tagArrayFixed, :location => params[:experience][:location], :street => params[:experience][:street], :city => params[:experience][:city], :postal_code => params[:experience][:postal_code])
        
        if params[:image]
            @experience.image.attach(params[:image])
        end
        
        # delete any existing associated location
        # YelpLocation.where(experience_id: params[:id]).destroy_all
        
        # # then create new associated location if there is one
        # if(params.has_key?(:yelp_id))
        #     # has a Yelp location selected
        #     YelpLocation.create(:experience_id => params[:id], :name => params[:yelp_name], :address => params[:yelp_address], :alias => params[:yelp_alias], :yelp_id => params[:yelp_id], :url => params[:yelp_url], :image_url => params[:yelp_image_url], :rating => params[:yelp_rating], :yelp_tags => params[:yelp_tags])
        # end
        redirect_to experience_path(params[:id])
    end

    def bookmarked
        if(params[:bookmarked] == "0")
            puts "destroying bookmark"
            Bookmark.where(experience_id: params[:experience_id]).where(user_id: current_user.id).destroy_all
        else
            puts "params of bookmark" + params[:bookmarked].to_s
            Bookmark.find_or_create_by(:bookmarked => params[:bookmarked], :user_id => current_user.id, :experience_id => params[:experience_id])
        end

        @experience = Experience.left_outer_joins(:user).select("experiences.*,users.name as user_name").where(experiences: {id: params[:experience_id]}).first

        @experience.hasUserBookmarked = 0
        bookmarked = Bookmark.select("bookmarked").where(experience_id: @experience.id).where(user_id: current_user.id).first
        if not bookmarked.nil?
            if bookmarked.bookmarked == 1
                @experience.hasUserBookmarked = 1
            end
        end
    end
    
    def experience_params
        params.require(:experience).permit(:title, :experience, :rating, :tags, :location, :street, :city, :postal_code, :image)
    end
end