class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        if(session.has_key? :user)
            my_user = Marshal.load session[:user]
            #puts "coming out of session: " + my_user.name
        end
        session.has_key? :user
    end
    def current_user
        Marshal.load session[:user] if logged_in?
    end
end
