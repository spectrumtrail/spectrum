class ApplicationMailer < ActionMailer::Base
  default from: 'contact@spectrumtrailrunning.com'
  layout 'mailer'
  append_view_path Rails.root.join('app', 'views', 'mailers')
end
