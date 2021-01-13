FactoryBot.define do
  factory :newsletter_signup do

    first_name { "First" }
    last_name { "Last" }
    email { "first.last@example.com" }
  end
end
