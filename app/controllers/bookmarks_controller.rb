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
end