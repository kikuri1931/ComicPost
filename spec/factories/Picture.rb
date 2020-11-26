FactoryBot.define do
  factory :picture do
    title { Faker::Lorem.characters(number:5) }
    introduction { Faker::Lorem.characters(number:20) }

    trait :comic do
      status { :マンガ }
    end
    
    trait :illustration do
      status { :イラスト }
    end
  end
end
