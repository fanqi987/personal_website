class StaticPagesController < ApplicationController

  after_action :store_current_url

  def home
  end

  def micropost
    redirect_to microposts_path
  end

  def diary
  end

  def hobby
  end

  def profile
  end

  def messageboard
  end

  def material
  end


end