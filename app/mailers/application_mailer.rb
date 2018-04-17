class ApplicationMailer < ActionMailer::Base
  default from: "e-Navigator <#{ENV['SMTP_USER_NAME']}>"
  layout 'mailer'
end
