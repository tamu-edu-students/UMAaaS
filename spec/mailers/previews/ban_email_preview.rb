# Preview all emails at http://localhost:3000/rails/mailers/ban_email
class BanEmailPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/ban_email/banned
  def banned
    user = User.third
    BanEmailMailer.banned(user)
  end

end
