class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_ACCOUNT_NAME')
  layout 'mailer'
end
