FactoryBot.define do
  factory :user do
    name {"山田太郎"}
    name_kana {"やまだたろう"}
    nickname {Faker::Lorem.characters(number: 20)}
    sequence(:email) { |n| "Test#{n}@example.com"}
    password {"password"}
    password_confirmation { 'password' }
    status :有料会員
      end
    end
  end
end
