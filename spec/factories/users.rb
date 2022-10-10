FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { :general }

    trait :admin do
      sequence(:email) { |n| "admin-#{n}@example.com" }
      role { :admin }
    end
  end
end
