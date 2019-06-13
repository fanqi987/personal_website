class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  ADMIN_ID = 1

  # def getCurrentRandomName
  #   @random_name ? @random_name : ""
  # end
  #
  # def setRandomName name
  #   @random_name = name
  # end

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

  def redirect_not_admin path, tips
    if (logged_in? && current_user.admin?)
      return false
    else
      flash[:danger] = tips
      redirect_to path
      return true
    end
  end

end
