class StaticPagesController < ApplicationController

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

  def messageboard
    redirect_to messages_path
  end

  def material
    redirect_to materials_path
  end

#剩下的内容
# 头像的设定,显示
# 微博图片和视频的上传
# 重设密码的邮件
# 404页面
# 分享功能
# 首页

end