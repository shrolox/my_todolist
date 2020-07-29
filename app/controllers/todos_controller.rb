class TodosController < ApplicationController
  before_action :authenticate_user

  def index
    @todos = current_user.todos.not_done.sorted
  end

  def done
    @todos = current_user.todos.done.sorted
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(params.require(:todo).permit(:title, :description, :due_date))
    @todo.user = current_user
    @todo.save

    if @todo.errors.any?
      render 'new'
    else
      redirect_to user_todos_path
    end
  end

  def update
  end

  def up_in_list
    @todo = Todo.find_by(id: params[:id])
    @todo.up_in_users_list
    redirect_to user_todos_path
  end

  def down_in_list
    @todo = Todo.find_by(id: params[:id])
    @todo.down_in_users_list
    redirect_to user_todos_path
  end

  def done
    @todo = Todo.find_by(id: params[:id])
    @todo.mark_done
    redirect_to user_todos_path
  end

  def destroy
    @todo = Todo.find_by(id: params[:id])
    @todo.destroy
    redirect_to user_todos_path
  end
end
