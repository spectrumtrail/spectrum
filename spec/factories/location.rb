FactoryBot.define do
  factory :location do
    name { "Fake Location" }
    description_html { "<p>Lorem Ipsum Ad Volorem</p>" }
    short_description { "Lorem Ipsum Ad Volorem" }
    external_website_link { "https://www.google.com" }

    trait :active do
      is_active { true }
    end

    trait :inactive do
      is_active { nil }
    end

    trait :with_cover_photo do
      cover_photo {
        fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png')
      }
    end

    trait :with_promo_photos do
      promo_photos {
        [fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png'), fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png')]
      }
    end
  end
end
