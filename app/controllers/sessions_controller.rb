# frozen_string_literal: true
require 'open-uri'

class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']

    # Allow non tamu emails for testing
    if params[:hd] != 'tamu.edu' && 1.zero?
      flash[:alert] = 'Must login with @tamu.edu email address!'
      redirect_to root_path and return
    end

    dbUser = User.find_by email: user_info['info']['email']
    if dbUser.nil?
      dbUser = User.create(uid: user_info['uid'], name: user_info['info']['name'],
                           email: user_info['info']['email'])
    elsif dbUser.banned
      flash[:alert] = 'Your account has been banned! Please contact the administrators.'
      redirect_to root_path and return
    end

    # if email address matches the one in the /config/application.rb file then make that user an admin
    if user_info['info']['email'] == Rails.configuration.admin_email
      dbUser.admin = true
      dbUser.save
    end
    
     # Attach the user's profile picture to their avatar
    if user_info['info']['image'].present? && !dbUser.avatar.attached?
      dbUser.avatar.attach(io: URI.open(user_info['info']['image']), filename: "#{dbUser.name}_avatar.jpg")
    end

    session[:user] = dbUser.id
    session[:user_admin] = dbUser.admin
    session[:user_img] = user_info['info']['image']
    session[:user_program_id] = dbUser.program_id
    session[:user_email] = dbUser.email

    redirect_to(root_path) and return
  end

  def destroy
    session.delete :user
    session.delete :user_admin
    session.delete :user_img
    session.delete :user_program_id
    session.delete :user_email
    redirect_to root_path
  end
end
