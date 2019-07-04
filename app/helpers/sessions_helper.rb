module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget
    session.delete(:user_id)
  end

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
      return @current_user
    end
    if (cookies[:user_id])
      @current_user = User.find(cookies[:user_id])
      return @current_user if @current_user.authenticate_digest(:remember, cookies[:remember_token])
    end
  end

  def logged_in?
    !!current_user
  end

  def remember(user)
    user.remember
    cookies.signed.permanent[:user_id] = user.id
    cookies[:remember_token] = {value: user.remember_token,
                                expires: 20.years.from_now.utc}
  end

  def forget
    current_user.forget if current_user
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end

  def check_show_delete comment
    return logged_in? &&
        (current_user.admin? || current_user.id ==
            comment.user_id)
  end

  def setAvatar(object)
    # if (logged_in? && (!current_user.avatar || current_user.avatar.empty?))
    # elsif (logged_in?)
    #   object.avatar = current_user.avatar
    # elsif cookies[:user_avatar]
    #   object.avatar = cookies[:user_avatar]
    # else
    # end
    if !logged_in? && cookies[:user_avatar]
      object.avatar = cookies[:user_avatar]
    end
  end
end
