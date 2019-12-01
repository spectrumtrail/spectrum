FactoryBot.define do
  factory :location do
    name { "Fake Location" }
    description_html { "<p>Lorem Ipsum Ad Volorem</p>" }
    short_description { "Lorem Ipsum Ad Volorem" }
    external_website_link { "https://www.google.com" }
  end
end
