require 'rails_helper'

RSpec.describe Todo, type: :model do
	before(:each) do
		@user = create(:user)
		@td1 = @user.todos.create(title: "title 1")
		@td2 = @user.todos.create(title: "title 2")
		@td3 = @user.todos.create(title: "title 3")
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

	it 'creates todos priorities in the right order' do
		expect(@td2.priority).to be < @td3.priority &&  be > @td1.priority 
	end

	it 'puts todos up correctly' do
		@td2.up_in_users_list
		@td1.reload
		@td2.reload
		@td3.reload
		expect(@td2.priority).to be < @td3.priority &&  be < @td1.priority 
	end

	it 'puts todos up correctly' do
		@td1.down_in_users_list
		@td1.reload
		@td2.reload
		@td3.reload
		expect(@td1.priority).to be > @td3.priority &&  be > @td2.priority 
	end

	it 'marks todos done correctly' do
		@td1.mark_done
		expect(@td1.status).to eq 1
	end
end
