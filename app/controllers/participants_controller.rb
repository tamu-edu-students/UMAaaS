# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :requireAdmin

  # Change to faculty perms
  def requireAdmin
    if logged_in?
      redirect_to root_path and return unless current_user.admin
    else
      redirect_to root_path and return
    end
  end

  def index
    @participants = Participant.where(program_id: params['program_id'])
  end

  def new
    @program = Program.find_by(id: params['program_id'])
    unless @program
      flash[:alert] = 'Cannot create participant'
      redirect_to programs_path and return
    end
    @participants = Participant.where(program_id: params['program_id'])
    @participant = Participant.new
  end

  def create
    puts params
    emails = params[:emails].split("\n").map(&:strip)
    is_faculty = params[:participant][:is_faculty]
    pid = params['program_id']
    if emails.empty? || is_faculty.blank? # required fields
      flash[:alert] = 'All fields are required'
      redirect_to new_program_participant_path(pid) and return
    end

    # Check existence and create new participants
    errors = []
    created_participants = []
    emails.each do |email|
      if Participant.find_by(email: email, program_id: pid).present? or !(email =~ URI::MailTo::EMAIL_REGEXP)
        errors << "#{email}"
      else
        Participant.create(email: email, is_faculty: is_faculty, program_id: pid)
        created_participants << email
      end
    end
    
    if errors.any?
      flash[:warning] = "Participant(s) already exist or invalid format: #{errors.join(', ')}"
    elsif created_participants.any?
      flash[:notice] = "Participant(s) successfully created!"
    end
    



    redirect_to new_program_participant_path(pid)
  end

  def edit
    @program = Program.find params[:id]
    @users = User.where(program_id: params[:id])
  end

  def update
    @program = Program.find params[:id]
    @program.update_attributes(name: params[:program][:name], location: params[:program][:location],
                               region: params[:program][:region])
    flash[:notice] = "#{@program.name} was successfully updated."
    redirect_to programs_path
  end

  def destroy
    @participant = Participant.find_by(id: params['id'])
    @participant.destroy
    flash[:notice] = "Participant ’#{@participant.email}’ deleted."
    redirect_to new_program_participant_path(params['program_id'])
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
end
