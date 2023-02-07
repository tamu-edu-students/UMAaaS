# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :requireAdmin

  def requireAdmin
    if logged_in?
      redirect_to root_path and return unless current_user.admin || session[:user].to_i == params[:id].to_i
    else
      redirect_to root_path and return
    end
  end

  def index
    if !params[:p].nil?
      # participants = Participant.where(program_id: params[:p])
      # @users = User.joins(:participants).where(programs: {program_id: params[:p]})
      @users = User.left_outer_joins(:program).select('users.*,programs.name as program_name').where(users: { program_id: params[:p] })
    else
      @users = User.left_outer_joins(:program).select('users.*,programs.name as program_name').all
    end

    if !params[:search].nil?
      searchResults = []
      print('------s-')
      search_term = params[:search]
      print('Search TErm is ', search_term)
      @users.each do |user|
        print('Looping', user[:name])
        full_name = (user[:name]).to_s
        if full_name =~ /#{search_term}/i
          puts "Found match: #{full_name}"
          searchResults << user
        end
      end
      @users = searchResults

    elsif params[:b] != 'true'
      @users = @users.where(banned: false)
    end

    @programs = Program.where(disabled: false)
    @selectedProgram = params[:p].to_i
    @showBanned = params[:b] == 'true'
  end

  def edit
    @user = User.find params[:id]
    @programs = Program.all
  end

  def update
    @user = User.find params[:id]
    if params[:program_id].to_i.positive?
      @user.update_attributes(program_id: params[:program_id])
      session[:user_program_id] = params[:program_id]
    else
      @user.update_attributes(program_id: nil)
      session[:user_program_id] = nil
    end
    flash[:notice] = "#{@user.name} was successfully updated."
    redirect_to users_path
  end

  def destroy; end

  def view
    print('__________________________')
  end

  # promote user to admin
  def promote
    user = User.find params[:id]
    if user.nil?
      flash[:alert] = 'Error promoting user: user not found.'
    else
      user.admin = true
      user.save
      flash[:notice] = "#{user.name} was promoted to admin."
    end
    redirect_to users_path
  end

  # demote user from admin
  def demote
    user = User.find params[:id]
    if user.nil?
      flash[:alert] = 'Error demoting user: user not found.'
    else
      user.admin = false
      user.save
      flash[:notice] = "#{user.name} was demoted from admin."
    end
    redirect_to users_path
  end

  # ban user
  def ban
    user = User.find params[:id]
    if user.nil?
      flash[:alert] = 'Error banning user: user not found.'
    else
      user.banned = true
      user.save
      flash[:notice] = "#{user.name} has been banned."
    end
    redirect_to users_path
  end

  # unban user
  def unban
    user = User.find params[:id]
    if user.nil?
      flash[:alert] = 'Error unbanning user: user not found.'
    else
      user.banned = false
      user.save
      flash[:notice] = "#{user.name} has been unbanned."
    end
    redirect_to users_path
  end
end
