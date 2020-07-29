class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.create(params.require(:user).permit(:email))
   	session[:user_id] = @user.id
   	redirect_to user_todos_url
  end

  def update
  end

  def destroy
  end
end
