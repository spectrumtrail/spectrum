require "rails_helper"

RSpec.describe Event, type: :model do
  describe "event model validations" do
    let(:event) { create :event }

    subject { event }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a short_description" do
      subject.short_description = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a starts_at" do
      subject.starts_at = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a time_zone" do
      subject.time_zone = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a registration_opens_at" do
      subject.registration_opens_at = nil

      expect(subject).to_not be_valid
    end

    it "is not valid without a registration_closes_at" do
      subject.registration_closes_at = nil

      expect(subject).to_not be_valid
    end
  end

  describe ".is_active" do
    let!(:is_active) {
      create(
        :event, :is_active
      )
    }
    let!(:not_active) {
      create(
        :event, :not_active
      )
    }

    subject { Event.is_active }

    it "includes events where is_active is true" do
      expect(subject).to include(is_active)
    end

    it "excludes events where is_active is not true" do
      expect(subject).not_to include(not_active)
    end
  end

  describe ".by_starts_at" do
    let(:events) do
      [
        create(:event, { starts_at: Time.current + 2.month }),
        create(:event, { starts_at: Time.current + 1.month }),
        create(:event, { starts_at: Time.current + 3.month })
      ]
    end
    let(:ordered_events) { events.sort_by { |event| event.starts_at } }

    subject { Event.by_starts_at }

    it "should order events by starts_at" do
      expect(subject).to eq(ordered_events)
    end
  end
end
