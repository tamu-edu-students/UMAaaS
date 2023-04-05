# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def logged_in?
    return true if Rails.env.test?

    !current_user.id.nil? && current_user.id.positive?
  end

  def current_user
    cu = User.new
    cu.admin = session[:user_admin]
    cu.email = session[:user_email]
    cu.img = session[:user_img]
    cu.id = session[:user]
    cu.user_program_id = session[:user_program_id]
    cu
  end
end
