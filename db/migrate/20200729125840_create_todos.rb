class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.integer :priority
      t.date :due_date
      t.references :user, foreign_key: true
      t.integer :status
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
