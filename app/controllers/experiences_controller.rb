class ExperiencesController < ApplicationController
    def new
        @experience = Experience.new
        program = Program.find params[:id]
        @near = program.location
    end
    
    def create
        newExperience = Experience.create(:experience => params[:experience][:experience], :rating => params[:experience][:rating], :user_id => session[:user], :program_id => params[:id])

        if(params.has_key?(:yelp_id))
            # has a Yelp location selected
            YelpLocation.create(:experience_id => newExperience.id, :name => params[:yelp_name], :address => params[:yelp_address], :alias => params[:yelp_alias], :yelp_id => params[:yelp_id], :url => params[:yelp_url], :image_url => params[:yelp_image_url], :rating => params[:yelp_rating], :yelp_tags => params[:yelp_tags])
        end
        
        
        redirect_to portal_path(params[:id])
    end
    
    
    def create_comment
        ExperienceComment.create(:comment => params[:commentText], :rating => params[:rating], :user_id => session[:user], :experience_id => params[:experienceId])
        @experience = Experience.left_outer_joins(:user).select("experiences.*,users.name as user_name").where(experiences: {id: params[:experienceId]}).first
        
        @experience.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: params[:experienceId]).where(users: {banned: false}).order(created_at: :desc)
        
        rating_sum = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:experienceId]).where(users: {banned: false}).group(:experience_id).sum(:rating).values[0]
        rating_sum += @experience.rating #add the original rating
        rating_count = ExperienceComment.left_outer_joins(:user).where(experience_id: params[:experienceId]).where(users: {banned: false}).where.not(rating: nil).count(:id)
        rating_count +=1 #add 1 for the original rating
        @experience.average_rating = (rating_sum.to_f / rating_count).round(1)
        
        @experienceDivId = "portal-experience-wrapper-" + params[:experienceId]
        
        respond_to do |format|
            format.js {}
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
end
