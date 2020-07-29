class User < ApplicationRecord
	validates :email, uniqueness: true

	has_many :todos
end
