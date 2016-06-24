FactoryGirl.define do
  factory :project do
    title         { Faker::Book.title }
    description   { Faker::StarWars.quote }
    due_date      { Faker::Date.forward }
  end
end
