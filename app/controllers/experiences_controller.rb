class ExperiencesController < ApplicationController
    def new
        @experience = Experience.new
    end
    
    def create
        Experience.create(:experience => params[:experience][:experience], :rating => params[:experience][:rating], :user_id => session[:user], :program_id => params[:id])
        #puts "THE RATING IS: " + params[:experience][:rating].to_s
        redirect_to portal_path(params[:id])
    end
    
    
    def create_comment
        puts "START INSERT HERE"
        ExperienceComment.create(:comment => params[:commentText], :rating => params[:rating], :user_id => session[:user], :experience_id => params[:experienceId])
        puts "WOULD INSERT HERE"
        respond_to do |format|
            format.json { render json: { results: params[:experienceId] } }
        end
    end
end
