FactoryBot.define do
  factory :registration do
    accepts_refund_terms { true }
    step_to_validate { "confirmation" }
  end
end
