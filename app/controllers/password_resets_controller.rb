class PasswordResetsController < ApplicationController

  before_action :init_post

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if !@user
      flash[:danger] = "邮箱不存在!"
      redirect_to new_password_reset_path
      return
    end
    @user.create_reset_digest
    if @user.send_password_reset_email
      flash[:success] = "重置邮件已经发送!"
    else
      flash[:danger] = "重置邮件发送失败!"
    end
    redirect_to new_password_reset_path
  end

  def update
    if (!@user.authenticate_digest("reset", params[:id]))
      flash[:danger] = "认证重置密码token失败"
      redirect_to edit_password_reset_url(params[:id], email: params[:email])
      return
    end
    if (@user.reset_expired?)
      flash[:danger] = "认证重置密码token已经过期,请重新发送"
      redirect_to edit_password_reset_url(params[:id], email: params[:email])
      return
    end
    if @user.update(password_reset_edit_params)
      flash[:success] = "重置密码成功!"
    else
      flash[:danger] = "重置密码失败!" + getObjectErrors(@user)
    end
    redirect_to edit_password_reset_url(params[:id], email: params[:email])
  end

  def new
    # if !@user
    #   flash[:danger] = "邮箱不存在!"
    #   redirect_to login_path
    # end
  end

  def edit
  end

  private

  def init_post
    @user = User.find_by(email: params[:email])
  end

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def password_reset_edit_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
