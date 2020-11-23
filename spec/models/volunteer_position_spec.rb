require "rails_helper"

RSpec.describe VolunteerPosition, type: :model do
  let!(:race) { create :race }
  let!(:event) { race.event }

  subject { VolunteerPosition.new(event_id: event.id, name: "Pizza Kitchen") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an event id" do
    subject.event_id = nil

    expect(subject).to_not be_valid
  end
end
