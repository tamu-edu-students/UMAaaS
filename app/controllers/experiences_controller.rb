class ExperiencesController < ApplicationController
    before_action :requireAdmin, only: [:delete, :delete_comment]
    
    def requireAdmin
        if logged_in?
            redirect_to root_path and return unless current_user.admin
        else
            flash[:alert] = "You must be an admin to perform that action!"
            redirect_to root_path and return
        end
    end
    
    def new
        @experience = Experience.new
        program = Program.find params[:id]
        @near = program.location
    end
    
    def create
        if(params[:experience][:experience].blank? || params[:experience][:rating].blank?) # experience and rating are required
            flash[:alert] = "Cannot create experience"
            redirect_to portal_path(params[:id]) and return
        end
        
        tagArray = params[:experience][:tags].split(",")
        tagArrayFixed = ","   # list of tags in database will begin and end with a comma, and no spaces around the commas
        tagArray.each do |tag|
            tag = tag.strip.upcase
            tagArrayFixed += tag + ","
        end

        
        newExperience = Experience.create(:experience => params[:experience][:experience], :rating => params[:experience][:rating], :tags => tagArrayFixed, :user_id => session[:user], :program_id => params[:id])

        if(params.has_key?(:yelp_id))
            # has a Yelp location selected
            YelpLocation.create(:experience_id => newExperience.id, :name => params[:yelp_name], :address => params[:yelp_address], :alias => params[:yelp_alias], :yelp_id => params[:yelp_id], :url => params[:yelp_url], :image_url => params[:yelp_image_url], :rating => params[:yelp_rating], :yelp_tags => params[:yelp_tags])
        end
        
        
        redirect_to portal_path(params[:id])
    end
    
    
    def view
        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {id: params[:id]}).where(users: {banned: false}).first
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
    end
    
    
    def create_comment
        ExperienceComment.create(:comment => params[:commentText], :rating => params[:rating], :user_id => session[:user], :experience_id => params[:experienceId])
        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {id: params[:experienceId]}).first
        
        @experience.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: params[:experienceId]).where(users: {banned: false}).order(created_at: :desc).limit(Rails.configuration.max_comments_shown)
        
        @experience.totalComments = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:id]).where(users: {banned: false}).count(:id)
        
        rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:experienceId]).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
        rating_sum += @experience.rating #add the original rating
        rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:experienceId]).where(users: {banned: false}).where.not(rating: nil).count(:id)
        rating_count +=1 #add 1 for the original rating
        @experience.average_rating = (rating_sum.to_f / rating_count).round(1)
        
        @experienceDivId = "portal-experience-wrapper-" + params[:experienceId]
        
        respond_to do |format|
            format.js {}  # code in views/experiences/create_comment.js.erb will return
        end
    end
    
    def yelp_search
        @results = search(params[:yelpTerm], params[:yelpLocation])
        puts @results
        
        respond_to do |format|
            format.json  { render :json => @results }
        end
    end
    
    
    def search(term, location)
        url = "#{Rails.configuration.YELP_API_HOST}#{Rails.configuration.YELP_SEARCH_PATH}"
        params = {
            term: term,
            location: location,
            limit: 10,
        }
        response = HTTP.auth("Bearer #{Rails.configuration.YELP_API_KEY}").get(url, params: params)
        response.parse
    end
    
    # deletes a whole experience
    def delete
        puts "DELETE"
        puts params[:id]
        
        # delete comments
        ExperienceComment.where(experience_id: params[:id]).destroy_all
        
        # delete associated location
        YelpLocation.where(experience_id: params[:id]).destroy_all
        
        # delete experience
        Experience.where(id: params[:id]).destroy_all
        
        respond_to do |format|
            format.js {}
        end
    end
    
    # deletes just 1 comment
    def delete_comment
        puts "DELETE COMMENT"
        puts params[:id]
        
        # delete comments
        experienceComment = ExperienceComment.find(params[:id])
        @experience = Experience.left_outer_joins(:user).left_outer_joins(:yelp_location).select("experiences.*,users.name as user_name,yelp_locations.name as yelp_name, yelp_locations.address as yelp_address, yelp_locations.alias as yelp_alias, yelp_locations.url as yelp_url, yelp_locations.image_url as yelp_image_url, yelp_locations.rating as yelp_rating").where(experiences: {id: experienceComment.experience_id}).first
        
        experienceComment.destroy
        
        @experience.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: @experience.id).where(users: {banned: false}).order(created_at: :desc)
        
        rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
        if(rating_sum.nil?)
            rating_sum = 0
        end
        rating_sum += @experience.rating #add the original rating
        rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: @experience.id).where(users: {banned: false}).where.not(rating: nil).count(:id)
        rating_count +=1 #add 1 for the original rating
        @experience.average_rating = (rating_sum.to_f / rating_count).round(1)
        
        @experienceDivId = "portal-experience-wrapper-" + @experience.id.to_s
        
        

        respond_to do |format|
            format.js {}   # code in views/experiences/delete_comment.js.erb will return
        end
    end
end
