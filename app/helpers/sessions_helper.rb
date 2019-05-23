module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget
    session.delete(:user_id)
  end

  def current_user
    return User.find(session[:user_id]) if session[:user_id]
    if (cookies[:user_id])
      user = User.find(cookies[:user_id])
      return user if User.authenticate_digest(:remember, cookies[:remember_token])
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
    current_user.forget
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end
end
