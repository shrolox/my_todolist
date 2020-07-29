Rails.application.routes.draw do
  	root to: "home#index"

  	resources :users, only: [:new, :create, :update, :destroy]

  	scope path: 'session/' do
  		get 'new', as: 'new_session', to: 'session#new'
  		post 'create', as: 'create_session', to: 'session#create'
  		delete 'delete', as: 'delete_session', to: 'session#destroy'
 	end

  	scope path: 'user/', as: 'user' do
  		resources :todos, only: [:index, :new, :create, :update, :destroy]
  		patch '/todo/:id/up', as: 'todo_up', to: 'todos#up_in_list'
  		patch '/todo/:id/down', as: 'todo_down', to: 'todos#down_in_list'
  	end
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
