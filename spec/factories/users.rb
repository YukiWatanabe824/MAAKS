# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "xxx#{n}@example.jp" }
    sequence(:password) { |n| "123456789ab#{n}" }

    trait :admin_user do
      name { 'yuki' }
      admin { 'true' }
    end

    trait :not_admin_user do
      name { 'not_admin' }
    end
  end
end
