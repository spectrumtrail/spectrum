class RaceRegistration::MailerPreview < ActionMailer::Preview
  def confirm
    RaceRegistrationMailer.with(registration: Registration.all.sample).confirm
  end
end
