class Todo < ApplicationRecord
  validates :title, presence: true

  belongs_to :user

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

  private def previous_todo
    self.user.todos.sorted.where(status: self.status).where("priority < ?", self.priority).last
  end

  private def next_todo
    self.user.todos.sorted.where(status: self.status).where("priority > ?", self.priority).first
  end

  def mark_done
    self.update(status: 1)
  end

  def mark_not_done
    self.update(status: 0)
  end

  def is_first
    todo_above = previous_todo
    return todo_above == nil
  end

  def is_last
    todo_under = next_todo
    return todo_under == nil
  end

  def up_in_users_list
  	todo_above = previous_todo
    if todo_above
      above_priority = todo_above.priority
  	  todo_above.update(priority: self.priority)
  	  self.update(priority: above_priority)
    end
  end

  def down_in_users_list
  	todo_under = next_todo
    if todo_under
      under_priority = todo_under.priority
  	  todo_under.update(priority: self.priority)
  	  self.update(priority: under_priority)
    end
  end
end
