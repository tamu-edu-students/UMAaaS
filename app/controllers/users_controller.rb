class UsersController < ApplicationController
  #belongs_to :program, optional: true
  
  def index
      @users = User.all
  end
  
  def edit
        @user = User.find params[:id]
        @programs = Program.all
  end
  
  def update
    @user = User.find params[:id]
    @user.update_attributes(:programs_id => params[:program_id])
    flash[:notice] = "#{@user.name} was successfully updated."
    redirect_to users_path
  end
  
  def destroy
  end
end
