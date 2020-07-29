class TodosController < ApplicationController
  before_action :authenticate_user

  def index
    @todos = current_user.todos.major.sorted
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(params.require(:todo).permit(:title, :description, :due_date))
    @todo.user = current_user
    @todo.save
    redirect_to user_todos_path
  end

  def update
  end

  def up_in_list
    @todo = Todo.find_by(params[:id])
    @todo.up_in_users_list
    redirect_to user_todos_path
  end

  def down_in_list
    @todo = Todo.find_by(params[:id])
    @todo.down_in_users_list
    redirect_to user_todos_path
  end

  def destroy
  end
end
