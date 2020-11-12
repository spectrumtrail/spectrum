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
    sendgrid_api_call
  end

  private

  def catch_exception(exception)
    ServiceResponse.new(
      message: exception.message + ' Please try again.',
      object: exception,
      success: false
    )
  end

  def sendgrid_api_call
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
    if response.status_code == '202'
      ServiceResponse.new(
        message: 'Thank you for signing up!',
        object: response,
        success: true
      )
    else
      ServiceResponse.new(
        message: 'Something went wrong, please try again.',
        object: response,
        success: false
      )
    end
  rescue => e
    catch_exception(e)
  end
end
