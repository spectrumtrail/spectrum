class NewsletterSignupsController < ApplicationController

  NewsletterSignup = Struct.new(:newsletter_signup, keyword_init: true)

  def create
    @newsletter_signup = NewsletterSignup.new(
      newsletter_signup: newsletter_signup_params
    )

    result = CreateNewsletterSignup.new(newsletter_signup: @newsletter_signup).call

    if result.success
      redirect_back(fallback_location: root_path, success: result.flash_message)
    else
      flash[:error] = result.flash_message
    end
  end

  private

  def newsletter_signup_params
    params.require(:newsletter_signup).permit!
  end
end
