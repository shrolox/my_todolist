class HomeController < ApplicationController
  def index
  	if current_user
  		redirect_to user_todos_url
  	end
  end
end
