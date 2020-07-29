class Todo < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  belongs_to :master_todo, class_name: "Todo", foreign_key: :master_todo_id, optional: true

  scope :major, -> { where(master_todo_id: nil) }
  scope :sorted, -> { order(priority: :asc) }

  before_create :set_priority

  private def set_priority
  	if (self.user)
  		max_priority = self.user.todos.maximum(:priority)
  		self.priority = max_priority ? max_priority + 1 : 1
  	else
  		self.priority = 0
  	end
  end

  def up_in_users_list
  	todo_above = self.user.todos.sorted.where(master_todo_id: self.master_todo_id).where("priority < ?", self.priority).last
  	above_priority = todo_above.priority
  	todo_above.update(priority: self.priority)
  	self.update(priority: above_priority)
  end

  def down_in_users_list
  	todo_above = self.user.todos.sorted.where(master_todo_id: self.master_todo_id).where("priority > ?", self.priority).first
  	under_priority = todo_under.priority
  	todo_under.update(priority: self.priority)
  	self.update(priority: under_priority)
  end
end
