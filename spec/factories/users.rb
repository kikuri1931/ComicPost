FactoryBot.define do
  factory :user do
    name {Faker::Internet.username(specifier: 5)}
    name_kana {Faker::Internet.username(specifier: 5)}
    postal_code {'000-0000'}
    address {Faker::Lorem.characters(number: 20)}
    telephone_number {'000-0000-0000'}
    sequence(:email) {Faker::Internet.email}
    password {"password"}
    password_confirmation { 'password' }
    status { :有料会員 }
  end
end
