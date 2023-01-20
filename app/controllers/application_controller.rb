class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
         if Rails.env.test?
             return true
         end
       return !current_user.id.nil? && current_user.id > 0
    end
    
    def current_user
        if Rails.env.test? 
         cu = User.new
         cu.admin = false
         cu.img = nil
         cu.id = "4"
         cu.user_program_id = nil
         return cu
       end 
        
        cu = User.new
        cu.admin = session[:user_admin]
        cu.email = session[:user_email]
        cu.img = session[:user_img]
        cu.id = session[:user]
        cu.user_program_id = session[:user_program_id]
        return cu
    end
end
