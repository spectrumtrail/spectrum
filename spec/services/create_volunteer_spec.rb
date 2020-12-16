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

    it "result object success attribute is true" do
      expect(result.success).to eq(true)
    end

    it "result object message is success_message" do
      expect(result.message).to eq(service.send(:success_message))
    end

    it "sends an email to the race director"

    it "sends an email to the volunteer"
  end

  context "when given an invalid volunteer" do
    let(:volunteer) { build(:volunteer, first_name: nil, event: event, volunteer_position: volunteer_position) }
    let(:result) { service.call }

    it "does not persist the volunteer to the database" do
      expect { result }.not_to change(Volunteer, :count)
    end

    it "returns a result object" do
      expect(result).to be_a(ServiceResult)
    end

    it "result object success attribute is false" do
      expect(result.success).to eq(false)
    end

    it "result object message is fail_message" do
      expect(result.message).to eq(service.send(:fail_message))
    end
  end
end
