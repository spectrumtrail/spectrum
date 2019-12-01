FactoryBot.define do
  factory :event do
    location

    name { "Fake Island" }
    short_description { "Lorem Ipsum" }
    starts_at { 2.months.from_now }
    time_zone { "Central Time (US & Canada)" }
    registration_opens_at { 1.day.from_now }
    registration_closes_at { 2.months.from_now - 1.day }
  end
end
