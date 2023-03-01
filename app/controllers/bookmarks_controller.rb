class BookmarksController < ApplicationController
    def new
        @bookmark = Bookmark.new
    end
    
    def create
    end
    
    def view
      @user = User.find params[:id]
      @bookmarks = Bookmark.left_outer_joins(:user).select("bookmarks.*").where(users: { id: params[:id]})
      @experiences = Array.new
      @titles = Array.new
      @bookmarks.each do |item|
        @experiences.append(item.experience_id)
        @titles.append(Experience.find(item.experience_id))
      end
    end
    def delete
    end
    def index
    end
   def bookmarked
        if(params[:bookmarked] == "0")
            puts "destroying bookmark"
            Bookmark.where(experience_id: params[:experience_id]).where(user_id: current_user.id).destroy_all
        else 
            puts "params of bookmark" + params[:bookmarked].to_s
            Bookmark.create(:bookmarked => params[:bookmarked], :user_id => current_user.id, :experience_id => params[:experience_id])
        end

        @experiences = Experience.left_outer_joins(:user).select("experiences.*,users.name as user_name").where(experiences: {id: params[:experience_id]}).first

        @experiences.hasUserBookmarked = 0
        bookmarked = Bookmark.select("bookmarked").where(experience_id: @experiences.id).where(user_id: current_user.id).first
        if not bookmarked.nil?
            if bookmarked.bookmark == 1
                @experiences.hasUserBookmarked = 1
            end
        end
    end
end