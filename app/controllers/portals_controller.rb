class PortalsController < ApplicationController
    def index
        @programs = Program.where(disabled: false)
        
        if logged_in?
            #if logged in and the user already has a program selected, then automatically go that program portal
            program = Program.find session[:user_program_id] unless session[:user_program_id].nil?
            if(not program.nil?) then
                redirect_to portal_path(program.id)
            end
        end
    end
    
    def program_select
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
    
    
    def program_view
        program = Program.find params[:program_id]
        if(program.nil?) then
            flash[:notice] = "Pogram not found!"
        else
            session[:user_program_id] = program.id
            redirect_to portal_path(program.id)
        end
    end
    
    def view
        @program = Program.find params[:id]
        @programs = Program.where(disabled: false)
        @tips = Tip.left_outer_joins(:user).select("tips.*,users.name as user_name").where(tips: {program_id: params[:id]})
        @experiences = Experience.left_outer_joins(:user).select("experiences.*,users.name as user_name").where(experiences: {program_id: params[:id]}).order(rating: :desc)
        @experiences.each do |exp|
            exp.comments = ExperienceComment.left_outer_joins(:user).select("experience_comments.*,users.name as user_name").where(experience_id: exp.id).order(created_at: :desc)
            
            rating_sum = ExperienceComment.where(experience_id: exp.id).group(:experience_id).sum(:rating).values[0]
            if(rating_sum.nil?)
                rating_sum = exp.rating #just the original rating
            else
                rating_sum += exp.rating #add the original rating
            end
            rating_count = ExperienceComment.where(experience_id: exp.id).where.not(rating: nil).count(:id)
            rating_count +=1 #add 1 for the original rating
            exp.average_rating = (rating_sum.to_f / rating_count).round(1)
        end
        
        if(params[:sort_exp].nil?) then
            @experience_sort_by = "rating"
        else
            @experience_sort_by = params[:sort_exp]
        end
        
        #already sorted by rating by default, so only need to sort if some else is selected
        if(@experience_sort_by == "avg_rating") then
            @experiences = @experiences.sort_by(&:average_rating).reverse!
        elsif(@experience_sort_by == "date") then
            @experiences = @experiences.sort_by(&:created_at).reverse!
        end

    end
end