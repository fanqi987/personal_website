class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include ApplicationHelper

  ADMIN_ID = 1
  COMMENT_PAGE_NUM = 10

  def store_current_url
    session[:current_url] = request.original_url if request.get?
    p '我是rail里面的p   ' + session[:current_url]
  end

  def check_logged_in
    unless logged_in?
      flash[:danger] = '请先登录哦~'
      redirect_to login_path
    end
  end

  def redirect_not_admin(path, tips)
    if (logged_in? && current_user.admin?)
      return false
    else
      flash[:warning] = tips
      if path
        redirect_to path
      else
        redirect_to request.original_url
      end
      return true
    end
  end

  def set_comment_user_attr object
    if (logged_in?)
      object.user_id = current_user.id
      object.user_name = current_user.name
    elsif params[:comment][:user_name] && !params[:comment][:user_name].empty?
      object.user_name = params[:comment][:user_name]
      session[:user_name] = params[:comment][:user_name]
    else
      object.user_name = request.remote_ip
    end
  end

  def like_common object
    p object
    if logged_in?
      @like = object.likes.find_by(user_name: current_user.name)
    else
      @like = object.likes.find_by(user_name: request.remote_ip)
    end

    #创建没有点赞过的人
    if !@like
      @like = object.likes.build
      if logged_in?
        @like.user_name = current_user.name
        @like.user_id = current_user.id
      else
        @like.user_name = request.remote_ip
      end
    end

    #保存之前点赞时间的备份
    @tmp_updated_at = @like.updated_at

    #保存新的点赞数据,并且更新ui,在更新ui前,才更新数据.
    if (@like.save)
      p "在rails里"
      respond_js
      return
    end
  end

  def respond_js
    respond_to do |format|
      format.html
      format.js
    end
  end


end
