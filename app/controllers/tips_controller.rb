class TipsController < ApplicationController
    def new
        @tip = Tip.new
    end
    
    def create
        if(params[:tip][:tip].blank?) # tip text is required
            flash[:alert] = "Cannot create tip"
            redirect_to portal_path(params[:id]) and return
        end
        
        Tip.create(:tip => params[:tip][:tip], :user_id => session[:user], :program_id => params[:id])
        redirect_to portal_path(params[:id])
    end
    
    def helpful
        if(params[:vote] == "0")
            
            HelpfulVote.where(tip_id: params[:tipId]).where(user_id: session[:user]).destroy_all
            
        else 
            
            HelpfulVote.where(tip_id: params[:tipId]).where(user_id: session[:user]).destroy_all
            HelpfulVote.create(:vote => params[:vote], :user_id => session[:user], :tip_id => params[:tipId])
            
        end
        
        @tip = Tip.left_outer_joins(:user).select("tips.*,users.name as user_name").where(tips: {id: params[:tipId]}).first


        upvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: @tip.id).where(users: {banned: false}).where(vote: 1).group(:tip_id).count(:vote).values[0]
        if upvote_sum.blank? 
            upvote_sum = 0
        end                 
        @tip.upvoteCount = upvote_sum
        
        downvote_sum = HelpfulVote.left_outer_joins(:user).where(tip_id: @tip.id).where(users: {banned: false}).where(vote: -1).group(:tip_id).count(:vote).values[0]
        if downvote_sum.blank? 
            downvote_sum = 0
        end 
        @tip.downvoteCount = downvote_sum
      


        @tip.hasUserUpvoted = 0
        @tip.hasUserDownvoted = 0
        helpful = HelpfulVote.select("vote").where(tip_id: @tip.id).where(user_id: session[:user]).first
        if not helpful.nil?
            if helpful.vote == 1
                @tip.hasUserUpvoted = 1
            elsif helpful.vote == -1
                @tip.hasUserDownvoted = 1
            end
        end
        
        @tipDivId = "portal-tip-wrapper-" + params[:tipId]

        
        
        respond_to do |format|
            format.js {}
        end
    end
end
