class RaceRegistrationConfirmation::MailerPreview < ActionMailer::Preview
  # hit http://localhost:3000/rails/mailers/devise/mailer/confirmation_instructions
  def new_registration
    RaceRegistrationConfirmationMailer.new_registration(Registration.first)
  end
end
