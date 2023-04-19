
class BanEmailMailer < ApplicationMailer
  default from: 'yijinfang611@gmail.com'

  def banned(user)
    @user = user
    mail(to: @user.email, subject: 'You have been banned')
  end
end
