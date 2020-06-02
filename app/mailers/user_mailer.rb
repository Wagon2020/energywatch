class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @user = params[:user] # Instance variable => available in view
    @url = "localhost:3000/users/sign_in"
    mail(to: @user.email, subject: 'Welcome to energywatch')
    # This will render a view in `app/views/user_mailer`!
  end
end
