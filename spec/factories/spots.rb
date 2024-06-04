# frozen_string_literal: true

FactoryBot.define do
  factory :spot do
    sequence(:title) { |n| "#{n}th test title" }
    accident_date { '2014-01-01 00:00:01' }

    trait :make_by_admin_user do
      accident_type { '自損' }
      contents { '走行中に左折レーンに入ってしまい直進しようとした際に、後方車列を振り向いて確認した際にふらついて落車' }
      longitude { '139.774373' }
      latitude { '35.684420' }
      association :user, :admin_user
    end

    trait :make_by_standard_user do
      accident_type { '人身' }
      contents { '走行中に左折レーンに入ってしまい直進しようとした際に、後方車列を振り向いて確認した際にふらついて落車' }
      longitude { '139.753003' }
      latitude { '35.685814' }
      association :user, :not_admin_user
    end
  end
end
