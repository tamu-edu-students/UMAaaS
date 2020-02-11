class TipsController < ApplicationController
    def new
        @tip = Tip.new
    end
    
    def create
        Tip.create(:tip => params[:tip][:tip], :user_id => session[:user], :program_id => params[:id])
        redirect_to portal_path(params[:id])
    end
end
