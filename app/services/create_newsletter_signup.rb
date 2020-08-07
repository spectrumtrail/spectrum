require 'sendgrid-ruby'
include SendGrid

class CreateNewsletterSignup
  attr_accessor :first_name, :last_name, :email, :list_ids, :api_key

  def initialize(first_name:, last_name:, email:, api_key: ENV['SENDGRID_API_KEY'], list_ids: [ENV['NEWSLETTER_LIST_ID']])
    @first_name = first_name
    @last_name = last_name
    @email = email
    @api_key = api_key
    @list_ids = list_ids
  end

  def perform
    signup_api_call
  end

  private

  def signup_api_call
    api_call_data = {
      'list_ids' => list_ids,
      'contacts' => [
        'first_name' => first_name,
        'last_name' => last_name,
        'email' => email
      ]
    }
    sg = SendGrid::API.new(api_key: api_key)
    response = sg.client.marketing.contacts.put(request_body: api_call_data)
  end
end
