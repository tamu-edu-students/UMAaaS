class UsersController < ApplicationController
  #belongs_to :program, optional: true
  
  def index
    puts "HERE WE GO!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      @users = User.all
  end
  
  def edit
  end
  
  def destroy
  end
end
