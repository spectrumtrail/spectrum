require "rails_helper"

RSpec.describe CreateNewsletterSignup do
  let(:service) { described_class.new(newsletter_signup: newsletter_signup) }
  let(:result) { service.call }
  let(:newsletter_signup) { 
    {
      first_name: "First",
      last_name: "Last",
      email: "first.last@example.com"
    }
  }

  subject {
    CreateNewsletterSignup.new(
        {
          newsletter_signup: newsletter_signup,
          api_key: "ThisIsNotTheRealKey",
          list_ids: ["ThisIsNotTheRealListId"]
        }
      )
  }

  describe CreateNewsletterSignup do
    it "exists" do
      puts "Look up here!"
      puts result.inspect
      expect(subject).to be_a(CreateNewsletterSignup)
    end
  end

  describe "newsletter signup object" do
    it "accepts a first name, last name, and email" do
      expect(subject.newsletter_signup[0][:first_name]).to eq('First')
      expect(subject.newsletter_signup[0][:last_name]).to eq('Last')
      expect(subject.newsletter_signup[0][:email]).to eq('first.last@example.com')
      expect(subject.api_key).to eq('ThisIsNotTheRealKey')
      expect(subject.list_ids).to eq(['ThisIsNotTheRealListId'])
    end
  end

  describe "#call" do
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

      subject.call

      expect(stub).to have_been_requested
    end
  end
end
