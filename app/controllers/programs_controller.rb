class ProgramsController < ApplicationController
  before_action :requireAdmin
  
  def requireAdmin
    if logged_in?
      redirect_to root_path and return unless current_user.admin
    else
      redirect_to root_path and return
    end
  end
  
  def index
    @programs = Program.all
    
    if params[:d] != "true" then
      @programs = @programs.where(disabled: false)
    end
    
    @showDisabled = params[:d] == "true"
  end
  
  def new
    @program = Program.new
  end
  
  def create
    if(params[:program][:name].blank? || params[:program][:location].blank? || params[:program][:region].blank?) # required fields
        flash[:alert] = "Cannot create program"
        redirect_to programs_path and return
    end
    
    @program = Program.create(:name => params[:program][:name], :location => params[:program][:location], :region => params[:program][:region])
    flash[:notice] = "#{@program.name} was successfully created."
    redirect_to programs_path
  end
  
  def edit
    @program = Program.find params[:id]
  end
  
  def update
    @program = Program.find params[:id]
    @program.update_attributes(:name => params[:program][:name], :location => params[:program][:location], :region => params[:program][:region])
    flash[:notice] = "#{@program.name} was successfully updated."
    redirect_to programs_path
  end
  
  
  # this is no longer called anywhere, programs aren't deleted, just disabled
  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    flash[:notice] = "Program ’#{@program.name}’ deleted."
    redirect_to programs_path
  end
  
  
  #disable program
  def disable
    program = Program.find params[:id]
    if(program.nil?) then
      flash[:alert] = "Error disabling program: program not found."
      redirect_to programs_path
    else
      program.disabled = true
      program.save
      flash[:notice] = "#{program.name} has been disabled."
      redirect_to programs_path
    end
  end
  
  #enable program
  def enable
    program = Program.find params[:id]
    if(program.nil?) then
      flash[:alert] = "Error enabling program: program not found."
      redirect_to programs_path
    else
      program.disabled = false
      program.save
      flash[:notice] = "#{program.name} has been enabled."
      redirect_to programs_path
    end
  end
end
