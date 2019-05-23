class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (@user.validate_modify_password(params[:user][:password]) && @user.save)
      flash[:success] = "注册成功啦！3秒后返回登录页面。"
      #TODO 登录,重新渲染,5秒后返回页面
      # login(@user)
      redirect_to register_success_path+'#register_success_body' and return
    else
      # 重新渲染
      render 'users/new'
    end
  end

  def destroy
  end

  def createSuccess
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end
