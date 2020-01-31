class SessionsController < ApplicationController
    def create
        user_info = request.env["omniauth.auth"]

        #if params[:hd] != 'tamu.edu'
        #    redirect_to root_path and return
        #end
        
        dbUser = User.find_by email: user_info["info"]["email"]
        if(dbUser.nil?)
            dbUser = User.create(uid: user_info["uid"], name: user_info["info"]["name"], email: user_info["info"]["email"])
        end

        user           = User.new
        user.id        = user_info["uid"]
        user.name      = user_info["info"]["name"]
        user.email     = user_info["info"]["email"]
        user.img       = user_info["info"]["image"]
        if(user.email == Rails.configuration.admin_email)
            dbUser.admin = true
            dbUser.save
            user.admin = true
        else
            user.admin = false
        end
    
        session[:user] = user.id
        session[:user_admin] = user.admin
        session[:user_img] = user.img

        redirect_to(root_path) and return
    end
    def destroy
        session.delete :user
        redirect_to root_path
    end
end
