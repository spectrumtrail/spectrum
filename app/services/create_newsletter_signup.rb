require 'sendgrid-ruby'
include SendGrid

class CreateNewsletterSignup
  attr_accessor :newsletter_signup, :api_key, :list_ids

  def initialize(newsletter_signup:, api_key: ENV['SENDGRID_API_KEY'], list_ids: [ENV['NEWSLETTER_LIST_ID']])
    @newsletter_signup = newsletter_signup,
    @api_key = api_key,
    @list_ids = list_ids
  end

  def call
    sendgrid_api_call
  end

  private

  def catch_exception(exception)
    ServiceResponse.new(
      message: exception.message + '. Please try again.',
      object: exception,
      success: false
    )
  end

  def sendgrid_api_call
    api_call_data = {
      'list_ids' => list_ids,
      'contacts' => [
        'first_name' => newsletter_signup[0].newsletter_signup[:first_name],
        'last_name' => newsletter_signup[0].newsletter_signup[:last_name],
        'email' => newsletter_signup[0].newsletter_signup[:email]
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
