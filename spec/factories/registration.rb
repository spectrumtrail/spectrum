FactoryBot.define do
  factory :registration do
    accepts_refund_terms { true }
    step_to_validate { "confirmation" }

    trait :paid do
      completed_at { Time.current }

      after(:create) do |registration, evaluator|
        create(:payment, registration: registration)
      end
    end
  end
end
