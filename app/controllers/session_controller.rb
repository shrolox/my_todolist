class SessionController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.find_by(email: params[:email])
   	if @user
      	session[:user_id] = @user.id
      	redirect_to user_todos_path
   	else
      	redirect_to new_session_path
   	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
