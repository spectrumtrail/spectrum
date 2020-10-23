class NewsletterSignupsController < ApplicationController

  def create
    signup = CreateNewsletterSignup.new(
      {
        first_name: newsletter_signup_params[:first_name],
        last_name: newsletter_signup_params[:last_name],
        email: newsletter_signup_params[:email]
      }
    ).perform

    if signup.class == SendGrid::Response
      response = JSON.parse(signup.body)
      if response['errors']
        redirect_back(fallback_location: root_path, error: response['errors'][0]['message'])
      else
        redirect_back(fallback_location: root_path, success: 'Thank you for signing up!')
      end
    else
      redirect_back(fallback_location: root_path, error: 'There was a problem with your request, please try again.')
    end
  end

  private

  def newsletter_signup_params
    params.require(:newsletter_signup).permit(:first_name, :last_name, :email)
  end
end
