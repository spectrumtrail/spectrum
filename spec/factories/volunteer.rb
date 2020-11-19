FactoryBot.define do
  factory :volunteer do
    event
    # volunteer_position

    first_name { "Foo" }
    last_name { "Bar" }
    phone { "3162588774" }
    email { "foobar@gmail.com" }
    time { "AM" }
  end
end
