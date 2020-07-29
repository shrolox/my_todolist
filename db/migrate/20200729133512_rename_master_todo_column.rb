class RenameMasterTodoColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :todos, :master_todo_id_id, :master_todo_id
  end
end
