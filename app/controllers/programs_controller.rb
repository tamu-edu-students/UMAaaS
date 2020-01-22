class ProgramsController < ApplicationController
  def index
    puts "TESTING"
    @programs = Program.all
    puts @programs.nil?
    @programs.each do |program|
      puts "Region: "
    end
  end
  
  def new
    @program = Program.new
  end
  
  def create
    params.require(:program).permit(:name, :region)
    params.require(:program).require(:name)
    params.require(:program).require(:region)
    @program = Program.create(:name => params[:program][:name], :region => params[:program][:region])
    redirect_to programs_path
  end
  
  def edit
    @program = Program.find params[:id]
  end
  
  def update
    @program = Program.find params[:id]
    @program.update_attributes(:name => params[:program][:name], :region => params[:program][:region])
    flash[:notice] = "#{@program.name} was successfully updated."
    redirect_to programs_path
  end
  
  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    flash[:notice] = "Program ’#{@program.name}’ deleted."
    redirect_to programs_path
  end
end
