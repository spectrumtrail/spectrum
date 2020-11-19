require "rails_helper"

RSpec.describe Volunteer, type: :model do
  let!(:race) { create :race }
  let!(:event) { race.event }
  let(:volunteer) {
    create(
      :volunteer,
      event: event
    )
  }

  subject { volunteer }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an event" do
    subject.event = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a first name" do
    subject.first_name = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a last name" do
    subject.last_name = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a phone number" do
    subject.phone = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    subject.email = nil

    expect(subject).to_not be_valid
  end

  it "is not valid without a time" do
    subject.time = nil

    expect(subject).to_not be_valid
  end
end
