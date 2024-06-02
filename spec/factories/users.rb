FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "xxx#{n}@example.jp" }
    sequence(:password) { |n| "123456789ab#{n}" }

    factory :admin_user do
      name { 'yuki' }
      admin { 'true' }
    end

    factory :not_admin_user do
      name { 'not_admin' }
    end
  end
end
