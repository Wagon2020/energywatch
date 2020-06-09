ActionMailer::Base.smtp_settings = {
  address: "mail.privateemail.com",
  port: 465,
  ssl: true,
  domain: 'www.privateemail123.com',
  user_name: ENV['MAIL_ADDRESS'],
  password: ENV['MAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
