
class BanEmailMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def banned(user)
    @user = user
    mail(to: @user.email, subject: 'You have been banned')
  end
end
