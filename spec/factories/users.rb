FactoryBot.define do
  factory :user do
    name {Faker::Internet.username(specifier: 5)}
    name_kana {Faker::Internet.username(specifier: 5)}
    sequence(:email) {Faker::Internet.email}
    password {"password"}
    password_confirmation { 'password' }

    trait :paid do
      postal_code {'000-0000'}
      address {Faker::Lorem.characters(number: 20)}
    	telephone_number {'000-0000-0000'}
      status { :有料会員 }
    end

    trait :free do
      status { :無料会員 }
    end
    trait :admin do
      status { :講師 }
    end
  end
end
