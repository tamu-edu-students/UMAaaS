class BookmarksController < ApplicationController
    def new
        @bookmark = Bookmark.new
    end
    
    def create
    end
    
    def view
      @user = User.find params[:id]
      @bookmarks = Bookmark.left_outer_joins(:user).select("bookmarks.*").where(users: { id: params[:id]})
      @experiences = 
    end   
    
    def delete
    end
end