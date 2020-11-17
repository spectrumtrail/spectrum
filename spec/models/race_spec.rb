require 'rails_helper'

RSpec.describe Race, type: :model do
  describe "race model validations" do
    let(:race) { create :race }

    subject { race }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil

      expect(subject).not_to be_valid
    end

    it "is not valid without a event" do
      subject.event = nil

      expect(subject).not_to be_valid
    end

    it "is not valid without a starts_at timestamp" do
      subject.starts_at = nil

      expect(subject).not_to be_valid
    end
  end

  describe ".active" do
    let(:active_race) { create(:race, :active) }
    let(:inactive_race) { create(:race, :inactive) }

    subject { Race.active }

    it "includes races where is_active is true" do
      expect(subject).to include(active_race)
    end

    it "excludes races where is_active is false" do
      expect(subject).not_to include(inactive_race)
    end
  end

  describe ".by_starts_at" do
    let(:races) do
      [
        create(:race, { starts_at: Time.current + 2.month }),
        create(:race, { starts_at: Time.current + 1.month }),
        create(:race, { starts_at: Time.current + 3.month })
      ]
    end
    let(:ordered_races) { races.sort_by { |race| race.starts_at } }

    subject { Race.by_starts_at }

    it "should order races by starts_at" do
      expect(subject).to eq(ordered_races)
    end
  end

  describe ".upcoming" do
    let(:upcoming_race) { create(:race, :upcoming) }
    let(:past_race) { create(:race, :past) }

    subject { Race.upcoming }

    it "includes races where starts_at is in the future" do
      expect(subject).to include(upcoming_race)
    end

    it "excludes races where starts_at is in the past" do
      expect(subject).not_to include(past_race)
    end
  end

  describe ".past" do
    let(:past_race) { create(:race, :past) }
    let(:upcoming_race) { create(:race, :upcoming) }

    subject { Race.past }

    it "includes races where starts_at is in the past" do
      expect(subject).to include(past_race)
    end

    it "excludes races where starts_at is in the future" do
      expect(subject).not_to include(upcoming_race)
    end
  end

  describe ".archived" do
    let(:archived_race) { create(:race, :archived) }
    let(:unarchived_race) { create(:race, :not_archived) }

    subject { Race.archived }

    it "includes races where archived_at is not nil" do
      expect(subject).to include(archived_race)
    end

    it "excludes races where archived_at is nil" do
      expect(subject).not_to include(unarchived_race)
    end
  end

  describe ".not_archived" do
    let(:unarchived_race) { create(:race, :not_archived) }
    let(:archived_race) { create(:race, :archived) }

    subject { Race.not_archived }

    it "include races where archived_at is nil" do
      expect(subject).to include(unarchived_race)
    end

    it "excludes races where archived_at is not nil" do
      expect(subject).not_to include(archived_race)
    end
  end
end
