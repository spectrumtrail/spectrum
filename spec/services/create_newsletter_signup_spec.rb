require "rails_helper"

RSpec.describe CreateNewsletterSignup do
  let(:newsletter_signup) {
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

  describe "newsletter signup object" do
    it "accepts a first name, last name, and email" do
      expect(newsletter_signup.first_name).to eq('Will')
      expect(newsletter_signup.last_name).to eq('Blake')
      expect(newsletter_signup.email).to eq('test@test.com')
      expect(newsletter_signup.api_key).to eq('ThisIsNotTheRealKey')
      expect(newsletter_signup.list_ids).to eq(['ThisIsNotTheRealListId'])
    end
  end

  describe "#perform" do
    it "sends a signup request to SendGrid api" do
      stub_request(:put, "https://api.sendgrid.com/v3/marketing/contacts").
        with(
          body: "{\"list_ids\":[\"newsletter_signup.list_ids\"],\"contacts\":[{\"first_name\":\"Will\",\"last_name\":\"Blake\",\"email\":\"test@test.com\"}]}",
          headers: {
        'Accept'=>'application/json',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization' => newsletter_signup.api_key,
        'Content-Type'=>'application/json',
        'User-Agent'=>'sendgrid/5.3.0;ruby'
          }).
        to_return(status: 200, body: "", headers: {})
    end
  end
end
