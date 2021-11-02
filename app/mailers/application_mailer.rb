class ApplicationMailer < ActionMailer::Base
  default from: 'randi@spectrumtrailracing.com'
  layout 'mailer'
  append_view_path Rails.root.join('app', 'views', 'mailers')
end
