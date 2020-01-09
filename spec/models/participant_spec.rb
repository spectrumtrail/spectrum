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
end
