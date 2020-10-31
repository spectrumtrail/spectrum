FactoryBot.define do
  factory :registration do
    step_to_validate { "details" }

    trait :paid do
      completed_at { Time.current }

      after(:create) do |registration, evaluator|
        create(:payment, registration: registration)
      end
    end
    trait :cancelled do
      cancelled_at { Time.current }
    end
    trait :not_cancelled do
      cancelled_at { nil }
    end
    trait :incomplete do
      completed_at { nil }
    end
    trait :last_thirty_days do
      started_at { Time.current - 29.days }
    end
    trait :over_thirty_days do
      started_at { Time.current - 31.days }
    end
    trait :over_twenty_four_hours do
      started_at { Time.current - 25.hours }
    end
    trait :under_twenty_four_hours do
      started_at { Time.current - 23.hours }
    end
  end
end
