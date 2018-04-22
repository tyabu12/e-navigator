class ApplicationMailer < ActionMailer::Base
  default from: "e-Navigator <#{Rails.application.secrets.default_mail_user}>"
  layout 'mailer'
end
