class SessionsController < ApplicationController

  before_action :check_logged_in, only: [:edit, :update_info, :update_pwd]

  PATCH_TYPE_INFO = 0
  PATCH_TYPE_PWD = 1
  attr_accessor :patch_type

  def new
  end

  def edit
    # @user.reload
    @user = current_user
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      remember(@user) if params[:session][:remember_me] == "1"
      flash[:success] = '登录成功,准备跳转至之前页面~'
    else
      flash[:danger] = "登录失败,检查你的邮箱和密码哦～"
    end
    redirect_to login_path + '#login_title'
  end

  def destroy
    log_out
    # p "正在登出"
    redirect_to login_path
  end

  def update_info
    p params
    @patch_type = PATCH_TYPE_INFO
    @user = current_user
    if @user.update_attributes(user_params_infos)
      flash.now[:success] = "更新用户信息成功~"
    else
      p @user.errors.map.to_a
    end
    render 'sessions/edit'

  end

  def update_pwd
    @patch_type = PATCH_TYPE_PWD
    @user = current_user
    if @user.validate_modify_password(params[:user][:password]) && (@user.update_attributes(user_params_pwd))
      flash.now[:success] = "更新用户密码成功"
    else
      p @user.errors.map.to_a
    end
    render 'sessions/edit'

  end

  def index
  end

  private

  def user_params_infos
    params.require(:user).permit(:email, :name)
  end

  def user_params_pwd
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end


end
