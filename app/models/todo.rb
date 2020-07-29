class Todo < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  belongs_to :master_todo, class_name: "Todo", foreign_key: :master_todo_id, optional: true

  scope :major, -> { where(master_todo_id: nil) }
  scope :sorted, -> { order(priority: :asc) }
  scope :done, -> { where(status: 1) }
  scope :not_done, -> { where(status: 0) }

  before_create :set_priority, :set_status

  private def set_priority
  	if (self.user)
  		max_priority = self.user.todos.maximum(:priority)
  		self.priority = max_priority ? max_priority + 1 : 1
  	else
  		self.priority = 0
  	end
  end

  private def set_status
    self.status = 0
  end

  def mark_done
    self.update(status: 1)
  end

  def mark_not_done
    self.update(status: 0)
  end

  def is_first
    
  end

  def is_last
    
  end

  def up_in_users_list
  	todo_above = self.user.todos.sorted.where(master_todo_id: self.master_todo_id).where("priority < ?", self.priority).last
    if todo_above
      above_priority = todo_above.priority
  	  todo_above.update(priority: self.priority)
  	  self.update(priority: above_priority)
    end
  end

  def down_in_users_list
  	todo_under = self.user.todos.sorted.where(master_todo_id: self.master_todo_id).where("priority > ?", self.priority).first
    if todo_under
      under_priority = todo_under.priority
  	  todo_under.update(priority: self.priority)
  	  self.update(priority: under_priority)
    end
  end
end
