class SessionsController < ApplicationController
    def create
        user_info = request.env["omniauth.auth"]

        if params[:hd] != 'tamu.edu'
            redirect_to root_path and return
        end

        user           = User.new
        user.id        = user_info["uid"]
        user.name      = user_info["info"]["name"]
        user.email     = user_info["info"]["email"]
        user.img = user_info["info"]["image"]
    
        session[:user] = Marshal.dump user

        redirect_to(root_path) and return
    end
    def destroy
        session.delete :user
        redirect_to root_path
    end
end
