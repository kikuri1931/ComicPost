FactoryBot.define do
  factory :picture do
    title { Faker::Lorem.characters(number:5) }
    introduction { Faker::Lorem.characters(number:20) }
    status { :マンガ }
    user
  end
end
