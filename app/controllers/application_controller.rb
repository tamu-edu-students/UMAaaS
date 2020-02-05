class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        session.has_key? :user
    end
    def current_user
        cu = User.new
        cu.admin = session[:user_admin]
        cu.img = session[:user_img]
        cu.id = session[:user]
        return cu
    end
end
