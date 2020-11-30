FactoryBot.define do
  factory :volunteer_position do
    event

    event_id { event.id }
    name { "Pizza Kitchen" }
  end
end
