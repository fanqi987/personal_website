class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "重置登录密码"
  end
end
