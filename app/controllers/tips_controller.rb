class TipsController < ApplicationController
    def new
        @tip = Tip.new
    end
    
    def create
        puts "PORTAL ID: " + params[:id].to_s + " user id: " + session[:user].to_s
        Tip.create(:tip => params[:tip][:tip], :user_id => session[:user], :program_id => params[:id])
        puts params[:tip][:tip]
        redirect_to portal_path(params[:id])
    end
end
