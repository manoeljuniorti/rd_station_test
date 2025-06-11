FactoryBot.define do
  factory :product do
    name { "Testephone v3" }
    price { 11.99 }

    trait :invalid do
      name { nil }
      price { -1 }
    end
  end
end
