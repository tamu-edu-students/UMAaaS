class ExperincesController < ApplicationController
    def new
        @experince = Experince.new
    end
    
    def create
        Experince.create(:experince => params[:experince][:experince], :rating => params[:experince][:rating], :user_id => session[:user], :program_id => params[:id])
        #puts "THE RATING IS: " + params[:experince][:rating].to_s
        redirect_to portal_path(params[:id])
    end
end
