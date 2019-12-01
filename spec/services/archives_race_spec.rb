require "rails_helper"

RSpec.describe ArchivesRace do
  let!(:race) { create :race }
  let!(:event) { race.event }
  let!(:participant) do
    create(
      :participant,
      event: event,
      race: event.races.first,
      registration: create(:registration, event: event)
    )
  end

  describe "#perform" do
    it "sets the race to archived" do
      ArchivesRace.new(race_id: race.id).perform

      expect(race.reload.archived?).to be true
    end

    it "sets the race's registrations to archived" do
      service = ArchivesRace.new(race_id: race.id)

      expect { service.perform }.to change {
        race.reload.registrations.archived.count
      }.by(race.reload.registrations.count)
    end
  end
end
