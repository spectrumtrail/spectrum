require "rails_helper"

RSpec.describe Location, type: :model do
  describe "location model associations" do
    let(:location) { create(:location) }

    subject { location }

    it "should have many events association" do
      expect(subject.class.reflect_on_association(:events).macro).to eq(:has_many)
    end

    it "should have many races through events association" do
      expect(subject.class.reflect_on_association(:races).macro).to eq(:has_many)
    end

    it "should have one cover_photo attached association" do
      expect(subject.class.reflect_on_association(:cover_photo_attachment).macro).to eq(:has_one)
    end

    it "should have many promo_photos attached association" do
      expect(subject.class.reflect_on_association(:promo_photos_attachments).macro).to eq(:has_many)
    end
  end

  describe "location model validations" do
    let(:location) { create :location }

    subject { location }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it "is not valid without a description_html" do
      subject.description_html = nil

      expect(subject).not_to be_valid
    end

    it "is not valid without a short_description" do
      subject.short_description = nil

      expect(subject).not_to be_valid
    end

    it "is not valid without a external_website_link" do
      subject.external_website_link = nil

      expect(subject).not_to be_valid
    end
  end

  describe ".active" do
    let(:active_location) { create :location, :active }
    let(:inactive_location) { create :location, :inactive }

    subject { Location.active }

    it "includes locations where is_active is true" do
      expect(subject).to include(active_location)
    end

    it "excludes locations where is_active is not true" do
      expect(subject).not_to include(inactive_location)
    end
  end

  describe "location photo attachments" do
    let(:location) { create(:location, :with_cover_photo, :with_promo_photos) }

    subject { location }

    it "has cover_photo attached" do
      expect(subject.cover_photo).to be_attached
    end

    it "has promo_photos attached" do
      expect(subject.promo_photos).to be_attached
    end

    it "has 2 promo_photos attached" do
      expect(subject.promo_photos.count).to eq(2)
    end
  end
end
