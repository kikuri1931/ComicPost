FactoryBot.define do
  factory :payment do
    payment {5000}
    taxin_payment {5500}
    status {:支払い済み}
  end
end
