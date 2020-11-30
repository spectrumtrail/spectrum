require "rails_helper"

RSpec.describe VolunteerPosition, type: :model do
  let!(:race) { create :race }
  let!(:event) { race.event }
  let(:volunteer_position) { create :volunteer_position }

  subject { volunteer_position }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an event id" do
    subject.event_id = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a name" do
    subject.name = nil

    expect(subject).to_not be_valid
  end
end
