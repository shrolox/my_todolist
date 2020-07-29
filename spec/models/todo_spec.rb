require 'rails_helper'

RSpec.describe Todo, type: :model do
	before(:each) do
		@user = create(:user)
	end
	
	it 'is not valid without an owner' do
		expect(Todo.new(title: "test")).to_not be_valid
	end
	
	it 'is not valid without a title' do
		expect(Todo.new(user: @user)).to_not be_valid
	end
	
	it 'is valid with only a title' do
		expect(Todo.new(user: @user, title: "test")).to be_valid
	end

end
