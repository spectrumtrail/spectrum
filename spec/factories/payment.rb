FactoryBot.define do
  factory :payment do
    registration

    amount_charged_in_cents { 100 }
  end
end
