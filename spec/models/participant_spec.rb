require "rails_helper"

RSpec.describe Participant, type: :model do
  describe ".to_event_start_list_csv" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:participants) do
      2.times do
        create(
          :participant,
          event: event,
          race: event.races.first,
          registration: create(:registration, :paid, event: event)
        )
      end
    end

    subject { Participant.to_event_start_list_csv(event_id: event.id) }

    it "generates a CSV with the expected headers" do
      first_row = subject.split("\n")

      expect(first_row).to eq(
        ["First Name,Last Name,Email,Age,Gender,Race,Location"]
      )
    end

    it "returns the expected number participant rows" do
      participant_rows = subject.split("\n").size - 1

      expect(participant_rows).to eq(Participant.count)
    end
  end

  describe ".incomplete_registrations" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:incomplete_registration) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :incomplete, event: event)
      )
    }
    let(:complete_registration) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :paid, event: event)
      )
    }

    subject { Participant.incomplete_registrations }

    it "includes participants with no completed_at timestamp on registration" do

      expect(subject).to include(incomplete_registration)
    end

    it "excludes participants with completed_at timestamp on registration" do

      expect(subject).not_to include(complete_registration)
    end
  end

  describe ".not_cancelled" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:not_cancelled) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :not_cancelled, event: event)
      )
    }
    let(:cancelled) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :cancelled, event: event)
      )
    }

    subject { Participant.not_cancelled }

    it "includes participants with no cancelled_at timestamp on registration" do

      expect(subject).to include(not_cancelled)
    end
    it "excludes participants with a cancelled_at timestamp on registration" do

      expect(subject).not_to include(cancelled)
    end
  end

  describe ".last_thirty_days" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:last_thirty_days) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :last_thirty_days, event: event)
      )
    }
    let!(:over_thirty_days) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :over_thirty_days, event: event)
      )
    }

    subject { Participant.last_thirty_days }

    it "includes participants with started_at timestamp within the last 30 days on registration" do

      expect(subject).to include(last_thirty_days)
    end

    it "excludes participants with started_at timestamp older than 30 days on registration" do

      expect(subject).not_to include(over_thirty_days)
    end
  end

  describe ".over_twenty_four_hours" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:over_twenty_four_hours) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :over_twenty_four_hours, event: event)
      )
    }
    let(:under_twenty_four_hours) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :under_twenty_four_hours, event: event)
      )
    }

    subject { Participant.over_twenty_four_hours }

    it "includes participants with started_at timestamp older than 24 hours on registration" do

      expect(subject).to include(over_twenty_four_hours)
    end
    it "excludes participants with started_at timestamp under 24 hours on registration" do

      expect(subject).not_to include(under_twenty_four_hours)
    end
  end

  describe ".abandoned_registration" do
    let!(:race) { create :race }
    let!(:event) { race.event }
    let(:abandoned_registration) {
      create(
        :participant,
        event: event,
        race: event.races.first,
        registration: create(:registration, :incomplete, :not_cancelled, :last_thirty_days, event: event)
      )
    }

    subject { Participant.abandoned_registrations }

    it "includes participants with registrations that are incomplete_registrations, not_cancelled, last_thirty_days, and over_twenty_four_hours" do

      expect(subject).to include(abandoned_registration)
    end
  end
end
