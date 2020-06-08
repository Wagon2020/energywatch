# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
# class UserMailerPreview < ActionMailer::Preview

#   # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
#   def welcome
#     UserMailer.welcome
#   end

# end

class UserMailerPreview < ActionMailer::Preview
  def welcome
    user = User.first
    # This is how you pass value to params[:user] inside mailer definition!
    UserMailer.with(user: user).welcome
  end
end
