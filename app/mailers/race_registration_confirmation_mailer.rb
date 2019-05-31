class RaceRegistrationConfirmationMailer < ApplicationMailer
  def new_registration(registration)
    @greeting = "Hi"

    mail to: registration.default_billing_email
  end
end
