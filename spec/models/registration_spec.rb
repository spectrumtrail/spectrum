require "rails_helper"

RSpec.describe Registration, type: :model do
  describe ".incomplete" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:participants) do
      1.times do
        create(
          :participant,
          event: event,
          race: event.races.first
        )
      end
    end
    let(:incomplete) {
      create(
        :registration,
        :incomplete,
        event: event
      )
    }
    let(:complete) {
      create(
        :registration,
        :paid,
        event: event
      )
    }

    subject { Registration.incomplete }

    it "includes registrations with no completed_at timestamp" do

      expect(subject).to include(incomplete)
    end

    it "excludes registrations with completed_at timestamp" do

      expect(subject).not_to include(complete)
    end
  end

  describe ".not_cancelled" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:participants) do
      1.times do
        create(
          :participant,
          event: event,
          race: event.races.first
        )
      end
    end
    let(:not_cancelled) {
      create(
        :registration,
        :not_cancelled,
        event: event
      )
    }
    let(:cancelled) {
      create(
        :registration,
        :cancelled,
        event: event
      )
    }

    subject { Registration.not_cancelled }

    it "includes registrations with no cancelled_at timestamp" do

      expect(subject).to include(not_cancelled)
    end
    it "excludes registrations with a cancelled_at timestamp" do

      expect(subject).not_to include(cancelled)
    end
  end

  describe ".last_thirty_days" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:participants) do
      1.times do
        create(
          :participant,
          event: event,
          race: event.races.first
        )
      end
    end
    let(:last_thirty_days) {
      create(
        :registration,
        :last_thirty_days,
        event: event
      )
    }
    let!(:over_thirty_days) {
      create(
        :registration,
        :over_thirty_days,
        event: event
      )
    }

    subject { Registration.last_thirty_days }

    it "includes registrations with started_at timestamp within the last 30 days" do

      expect(subject).to include(last_thirty_days)
    end

    it "excludes registrations with started_at timestamp older than 30 days" do

      expect(subject).not_to include(over_thirty_days)
    end
  end

  describe ".over_twenty_four_hours" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:participants) do
      1.times do
        create(
          :participant,
          event: event,
          race: event.races.first
        )
      end
    end
    let(:over_twenty_four_hours) {
      create(
        :registration,
        :over_twenty_four_hours,
        event: event
      )
    }
    let(:under_twenty_four_hours) {
      create(
        :registration,
        :under_twenty_four_hours,
        event: event
      )
    }

    subject { Registration.over_twenty_four_hours }

    it "includes registrations with started_at timestamp older than 24 hours" do

      expect(subject).to include(over_twenty_four_hours)
    end
    it "excludes registrations with started_at timestamp under 24 hours" do

      expect(subject).not_to include(under_twenty_four_hours)
    end
  end

  describe ".abandoned" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:participants) do
      1.times do
        create(
          :participant,
          event: event,
          race: event.races.first
        )
      end
    end
    let(:abandoned) {
      create(
        :registration,
        :incomplete,
        :not_cancelled,
        :last_thirty_days,
        :over_twenty_four_hours,
        event: event
      )
    }

    subject { Registration.abandoned }

    it "includes registrations that are incomplete_registrations, not_cancelled, last_thirty_days, and over_twenty_four_hours" do

      expect(subject).to include(abandoned)
    end
  end
end
