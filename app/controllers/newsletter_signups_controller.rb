class NewsletterSignupsController < ApplicationController

  NewsletterSignup = Struct.new(:first_name, :last_name, :email, keyword_init: true)

  def create
    newsletter_signup = NewsletterSignup.new(
      {
        first_name: newsletter_signup_params[:first_name],
        last_name: newsletter_signup_params[:last_name],
        email: newsletter_signup_params[:email]
      }
    )

    result = CreateNewsletterSignup.new(**newsletter_signup.to_h).perform

    if result.success
      redirect_back(fallback_location: root_path, success: result.flash_message)
    else
      flash[:error] = result.flash_message
    end
  end

  private

  def newsletter_signup_params
    params.require(:newsletter_signup).permit(:first_name, :last_name, :email)
  end
end
