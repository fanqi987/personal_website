class StaticPagesController < ApplicationController

  before_action :init_home, only: [:home]
  after_action :store_current_url

  def home
    p cookies[:user_id]
  end

  def micropost
    redirect_to microposts_path
  end

  def diary
    redirect_to diaries_path
  end

  def hobby
    redirect_to hobbies_path
  end

  def profile
  end

  def login_admin
    @user = User.find_by(id: ADMIN_ID)
    if @user
      log_in @user
      flash[:success] = "已登录为管理员!"
    else
      flash[:danger] = "登录为管理员失败了!"
    end
    redirect_to root_path
  end

  def messageboard
    redirect_to messages_path
  end

  def material
    redirect_to materials_path
  end

  private

  def init_home
    @user = User.find_by(id: ADMIN_ID)
    @micropost = @user.microposts.length > 0 ? @user.microposts[0] : nil
    @diary = @user.diaries.length > 0 ? @user.diaries[0] : nil
    @comment = (@user.message && @user.message.comments.length > 0) ? @user.message.comments[0] : nil
    @hobby_item = (@user.hobby_items.length > 0) ? @user.hobby_items[0] : nil
    @material = @user.materials.length > 0 ? @user.materials[0] : nil
  end

#剩下的内容
## 头像的设定,显示
## 微博图片和视频的上传
## 重设密码的邮件
## 404页面
## 分享功能
# 首页

end