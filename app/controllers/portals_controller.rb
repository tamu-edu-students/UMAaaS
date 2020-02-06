class PortalsController < ApplicationController
    def index
        @programs = Program.all
        
        if logged_in?
            #if logged in and the user already has a program selected, then automatically go that program portal
            program = Program.find session[:user_program_id] unless session[:user_program_id].nil?
            if(not program.nil?) then
                redirect_to portal_path(program.id)
            end
        end
    end
    
    def program_redirect
        program = Program.find params[:program_id]
        if(program.nil?) then
            flash[:notice] = "Pogram not found!"
        else
            if logged_in?
                #save selected program to the user account so next time they don't have to select it
                user = User.find session[:user]
                if(not user.nil?) then
                    user.program_id = program.id
                    user.save
                    session[:user_program_id] = program.id
                end
            end
            redirect_to portal_path(program.id)
        end
    end
    
    def view
        @program = Program.find params[:id]
        @programs = Program.all
    end
end
