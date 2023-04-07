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
    email = params[:participant][:email]
    is_faculty = params[:participant][:is_faculty]
    pid = params['program_id']
    if email.blank? || is_faculty.blank? # required fields
      flash[:alert] = 'All fields are required'
      redirect_to new_program_participant_path(pid) and return

    end

    # Check existence
    if Participant.find_by(email:, program_id: pid) != nil
      flash[:alert] = 'Participant Already exists'
      redirect_to new_program_participant_path(pid) and return
    end

    @participant = Participant.create(email:, is_faculty:, program_id: pid)
    flash[:notice] = 'Participant was successfully created.'

    puts(/LENGTH: #{Participant.all.length}/)
    redirect_to new_program_participant_path(pid)
  end

  def destroy
    @participant = Participant.find_by(id: params['id'])
    @participant.destroy
    flash[:notice] = "Participant ’#{@participant.email}’ deleted."
    redirect_to new_program_participant_path(params['program_id'])
  end

end
