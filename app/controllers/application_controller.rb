class ApplicationController < ActionController::Base

	def current_user
    	User.find_by(id: session[:user_id])
	end

	def authenticate_user
	   	redirect_to new_session_path unless current_user != nil
	end
end
