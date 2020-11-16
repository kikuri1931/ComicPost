FactoryBot.define do
  factory :genre do
    genre { Faker::Lorem.characters(number:5) }
    is_active { :true }
  end
end