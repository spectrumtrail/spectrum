require "rails_helper"

RSpec.describe CreateVolunteer do
  let(:service) { described_class.new(volunteer: volunteer) }
  let(:result) { service.call }
  let(:event) { create(:event) }
  let(:volunteer_position) { create(:volunteer_position, event: event) }
  let(:volunteer) { build(:volunteer, event: event, volunteer_position: volunteer_position) }

  context "when given a valid volunteer" do
    it "persists the volunteer to the database" do
      expect { service.call }.to change(Volunteer, :count).by(1)
    end

    it "returns a result object" do
      expect(result).to be_a(ServiceResult)
    end

    it "sends an email to the race director"

    it "sends an email to the volunteer"
  end
end
