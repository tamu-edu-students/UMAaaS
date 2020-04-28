class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        !current_user.id.nil? && current_user.id > 0
    end
    
    def current_user
        cu = User.new
        cu.admin = session[:user_admin]
        cu.img = session[:user_img]
        cu.id = session[:user]
        cu.user_program_id = session[:user_program_id]
        return cu
    end
end
