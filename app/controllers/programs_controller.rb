# frozen_string_literal: true

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
    @participants = Participant.where(program_id: params['program_id'])

    @programs = @programs.where(disabled: false) if params[:d] != 'true'

    @showDisabled = params[:d] == 'true'
  end

  def new
    @program = Program.new
    @participants = Participant.where(program_id: params['program_id'])
  end

  def create
    if params[:program][:name].blank? || params[:program][:location].blank? || params[:program][:region].blank? # required fields
      flash[:alert] = 'Cannot create program'
      redirect_to programs_path and return
    end
    
    @program = Program.create(:name => params[:program][:name], :location => params[:program][:location], :region => params[:program][:region])
    
    if params[:banners]
      @program.banners.attach(params[:banners])
    end
        
    flash[:notice] = "#{@program.name} was successfully created."
    redirect_to programs_path
  end

  def edit
    @participants = Participant.where(program_id: params[:id])
    @program = Program.find params[:id]
    @users = User.where(program_id: params[:id])
    
  end

  def update
    @program = Program.find params[:id]
    @program.update_attributes(name: params[:program][:name], location: params[:program][:location],
                              region: params[:program][:region])
    if params[:banners]
      @program.banners.attach(params[:banners])
    end
    flash[:notice] = "#{@program.name} was successfully updated."
    redirect_to programs_path
  end

  # disable program
  def disable
    program = Program.find params[:id]
    if program.nil?
      flash[:alert] = 'Error disabling program: program not found.'
    else
      program.disabled = true
      program.save
      flash[:notice] = "#{program.name} has been disabled."
    end
    redirect_to programs_path
  end

  # enable program
  def enable
    program = Program.find params[:id]
    if program.nil?
      flash[:alert] = 'Error enabling program: program not found.'
    else
      program.disabled = false
      program.save
      flash[:notice] = "#{program.name} has been enabled."
    end
    redirect_to programs_path
  end
  
  def flagged 
    @program = Program.find(params[:id])
    @tips = FlagTip.joins(:tip).where(tips: { program_id: @program.id })
    @experiences = FlagExperience.joins(:experience).where(experiences: { program_id: @program.id })
  end
  
  
  
  
  require 'aws-sdk-s3'

    def image_gallery
        @program = Program.find params[:id]
        @experiences = Experience.where(experiences: { program_id: @program.id }) # array of all experiences
        
        
        # s3 = Aws::S3::Resource.new(region: 'us-east-1')
        # bucket = s3.bucket('tripagvisor2')
        # @images = []
        # bucket.objects.each do |obj|
        # if obj.key.start_with?("uploads/#{params[:id]}")
        #   @images << obj.presigned_url(:get)
        # end
        # end
        
       
        render 'image_gallery'
    end


  
  
  
  
  
  def program_params
        params.require(:experience).permit(:name, :location, :region, {banners: []})
  end
    
end