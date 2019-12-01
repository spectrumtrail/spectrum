FactoryBot.define do
  factory :race do
    event

    sequence :name do |n|
      "Race #{n}"
    end

    starts_at { 2.months.from_now }
  end
end
