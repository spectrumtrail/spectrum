FactoryBot.define do
  factory :volunteer_position do
    event

    sequence :name do |n|
      "Position #{n}"
    end
  end
end
