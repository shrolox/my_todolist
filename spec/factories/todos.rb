FactoryBot.define do
  factory :todo do
    priority { 1 }
    due_date { "2020-07-29" }
    user { nil }
    master_todo_id { nil }
    status { 1 }
    title { "MyString" }
    description { "MyText" }
  end
end
