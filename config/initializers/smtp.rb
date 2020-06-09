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


# :address              => "smtp.gmail.com",
#   :port                 => 587,
#   :user_name            => "my-gmail-address@gmail.com",
#   :password             => "my-gmail-password",
#   :authentication       => "plain",
#   :enable_starttls_auto => true


  # address: "mail.privateemail.com",
  # port: 465,
  # ssl: true,
  # domain: 'privateemail.com',
  # user_name: ENV['MAIL_ADDRESS'],
  # password: ENV['MAIL_APP_PASSWORD'],
  # authentication: :login,
  # enable_starttls_auto: true
