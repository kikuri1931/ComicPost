FactoryBot.define do
  factory :genre do
    genre { Faker::Lorem.characters(number:5) }
    trait :active do
      is_active { true }
    end

    trait :delete do
      is_active { false }
    end
    
  end
end