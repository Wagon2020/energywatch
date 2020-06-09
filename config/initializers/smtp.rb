ActionMailer::Base.smtp_settings = {
  address: "mail.privateemail.com",
  port: 465,
  domain: 'privateemail.com',
  user_name: ENV['MAIL_ADDRESS'],
  password: ENV['MAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
