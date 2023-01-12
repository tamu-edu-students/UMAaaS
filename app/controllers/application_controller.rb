class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
         if Rails.env.test?
             
             return true
         end
        !current_user.id.nil? && current_user.id > 0
    end
    
    def current_user
        if Rails.env.test? 
         cu = User.new
         cu.admin = true
         cu.img = nil
         cu.id = "43242342342"
         cu.user_program_id = 1
         return cu
       end 
        
        cu = User.new
        cu.admin = session[:user_admin]
        cu.img = session[:user_img]
        cu.id = session[:user]
        cu.user_program_id = session[:user_program_id]
        return cu
    end
end
