FactoryBot.define do
  factory :volunteer do
    event
    after(:build) do |volunteer|
      volunteer.volunteer_position = build(:volunteer_position)
    end

    first_name { "Foo" }
    last_name { "Bar" }
    email { "foobar@gmail.com" }
    phone { "3162588774" }
    time { "AM" }
  end
end
