FactoryBot.define do
  factory :participant do
    event
    race
    registration

    first_name { "Foo" }
    last_name { "Bar" }
    email { "foobar@gmail.com" }
    phone { "3162588774" }
    birth_date { 30.years.ago }
    division { "Male" }
    address { "3426 W Elizabeth St" }
    city { "Fort Collins" }
    state { "CO" }
    emergency_contact_name { "Meg Richard" }
    emergency_contact_phone { "3035501027" }
    accepts_waiver { true }
  end
end
