class UsersController < ApplicationController
  
  def index
      @users = User.left_outer_joins(:program).select("users.*,programs.name as program_name").all
      #puts @users.program_name
  end
  
  def edit
        @user = User.find params[:id]
        @programs = Program.all
  end
  
  def update
    @user = User.find params[:id]
    if(params[:program_id].to_i > 0) then
      @user.update_attributes(:program_id => params[:program_id])
    else
      @user.update_attributes(:program_id => nil)
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
      flash[:notice] = "Error promoting user"
      redirect_to users_pth
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
      flash[:notice] = "Error demoting user"
      redirect_to users_pth
    else
      user.admin = false
      user.save
      flash[:notice] = "#{user.name} was demoted from admin."
      redirect_to users_path
    end
  end
end
