
class BanEmailMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def banned(user, ban_reason)
    @user = user
    @ban_reason = ban_reason
    mail(to: @user.email, subject: 'You Have Been Banned')
  end
end
