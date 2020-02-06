class UsersController < ApplicationController
  before_action :requireAdmin
  
  def requireAdmin
    if logged_in?
      redirect_to root_path and return unless (current_user.admin || session[:user].to_i == params[:id].to_i)
    else
      redirect_to root_path and return
    end
  end
  
  def index
      if not params[:p].nil? then
        @users = User.left_outer_joins(:program).select("users.*,programs.name as program_name").where(users: {program_id: params[:p]})
      else
        @users = User.left_outer_joins(:program).select("users.*,programs.name as program_name").all
      end
      
      if params[:b] != "true" then
        @users = @users.where(banned: false)
      end
      
      @programs = Program.all
      @selectedProgram = params[:p].to_i
      @showBanned = params[:b] == "true"
  end
  
  def edit
        @user = User.find params[:id]
        @programs = Program.all
  end
  
  def update
    @user = User.find params[:id]
    if(params[:program_id].to_i > 0) then
      @user.update_attributes(:program_id => params[:program_id])
      session[:user_program_id] = params[:program_id]
    else
      @user.update_attributes(:program_id => nil)
      session[:user_program_id] = nil
    end
    flash[:notice] = "#{@user.name} was successfully updated."
    redirect_to users_path
  end
  
  def destroy
  end
  
  #promote user to admin
  def promote
    user = User.find params[:id]
    if(user.nil?) then
      flash[:alert] = "Error promoting user: user not found."
      redirect_to users_path
    else
      user.admin = true
      user.save
      flash[:notice] = "#{user.name} was promoted to admin."
      redirect_to users_path
    end
  end
  
  #demote user from admin
  def demote
    user = User.find params[:id]
    if(user.nil?) then
      flash[:alert] = "Error demoting user: user not found."
      redirect_to users_path
    else
      user.admin = false
      user.save
      flash[:notice] = "#{user.name} was demoted from admin."
      redirect_to users_path
    end
  end
  
  #ban user
  def ban
    user = User.find params[:id]
    if(user.nil?) then
      flash[:alert] = "Error banning user: user not found."
      redirect_to users_path
    else
      user.banned = true
      user.save
      flash[:notice] = "#{user.name} has been banned."
      redirect_to users_path
    end
  end
  
  #unban user
  def unban
    user = User.find params[:id]
    if(user.nil?) then
      flash[:alert] = "Error unbanning user: user not found."
      redirect_to users_path
    else
      user.banned = false
      user.save
      flash[:notice] = "#{user.name} has been unbanned."
      redirect_to users_path
    end
  end
  
end
