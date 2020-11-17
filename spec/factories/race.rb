FactoryBot.define do
  factory :race do
    event

    sequence :name do |n|
      "Race #{n}"
    end

    starts_at { 2.months.from_now }

    trait :active do
      is_active { true }
    end

    trait :inactive do
      is_active { false }
    end

    trait :upcoming do
      starts_at { Time.current + 2.weeks }
    end

    trait :past do
      starts_at { Time.current - 1.day }
    end

    trait :archived do
      archived_at { Time.current - 1.hour }
    end

    trait :not_archived do
      archived_at { nil }
    end
  end
end
