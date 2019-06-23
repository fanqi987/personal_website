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
  end

  def material
  end


end