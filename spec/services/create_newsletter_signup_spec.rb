require "rails_helper"

RSpec.describe CreateNewsletterSignup do
  subject {
    CreateNewsletterSignup.new(
        {
          first_name: "Will",
          last_name: "Blake",
          email: "test@test.com",
          api_key: "ThisIsNotTheRealKey",
          list_ids: ["ThisIsNotTheRealListId"]
        }
      )
  }

  describe CreateNewsletterSignup do
    it "exists" do
      expect(subject).to be_a(CreateNewsletterSignup)
    end
  end

  describe "newsletter signup object" do
    it "accepts a first name, last name, and email" do
      expect(subject.first_name).to eq('Will')
      expect(subject.last_name).to eq('Blake')
      expect(subject.email).to eq('test@test.com')
      expect(subject.api_key).to eq('ThisIsNotTheRealKey')
      expect(subject.list_ids).to eq(['ThisIsNotTheRealListId'])
    end
  end

  describe "#perform" do
    it "sends a signup request to SendGrid api" do
      stub = stub_request(:put, "https://api.sendgrid.com/v3/marketing/contacts").
        with(
          body: "{\"list_ids\":" + subject.list_ids.to_s + ",\"contacts\":[{\"first_name\":\"Will\",\"last_name\":\"Blake\",\"email\":\"test@test.com\"}]}",
          headers: {
            'Accept'=>'application/json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => "Bearer " + subject.api_key,
            'Content-Type'=>'application/json',
            'User-Agent'=>'sendgrid/5.3.0;ruby'
          }).
        to_return(status: 200, body: "", headers: {})

      subject.perform

      expect(stub).to have_been_requested
    end
  end
end
