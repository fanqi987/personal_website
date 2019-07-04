class HobbiesController < ApplicationController
  before_action :init_post

  HOBBY_GROUP_NUM = 6

  def index
    cookies.delete(:created_hobby_id)
    p cookies[:user_id]
    @hobbies = @user.hobbies
    p @hobbies
    @group_num = (@hobbies.length * 1.0 / HOBBY_GROUP_NUM).ceil
    @group_hobbies = []
    (0...@group_num).each do |i|
      @group_hobbies[i] = @hobbies[((0 + i * HOBBY_GROUP_NUM)...(HOBBY_GROUP_NUM + i * HOBBY_GROUP_NUM))]
    end
    p @group_hobbies
  end

  def edit
    @hobby = @user.hobbies.find_by(id: params[:id])
  end

  def update
    @hobby = Hobby.find_by(id: params[:id])
    @hobby.update_attribute(:title, params[:hobby][:title])
    @hobby.update_attribute(:content, params[:hobby][:content])
    @hobby.reload
    flash.now[:success] = "修改画廊成功!"
    respond_js
  end

  def update_image
    @hobby_item = HobbyItem.find_by(id: params[:picture][:id])
    case (params[:button])
    when "title"
      @hobby_item.update_attribute(:title, params[:picture][:title])
    when "content"
      @hobby_item.update_attribute(:content, params[:picture][:content])
    when "like"
      like_common @hobby_item
      return
    when "cover"
      @tmp_hobby_item = @hobby_item.hobby.hobby_items.find_by(cover: true)
      if @tmp_hobby_item && (@tmp_hobby_item.id == @hobby_item.id)
        respond_js
        return
      elsif @tmp_hobby_item
        @tmp_hobby_item.update_attribute(:cover, false)
      end
      @hobby_item.update_attribute(:cover, true)
    end
    respond_js
  end

  def create
    p params
    @hobbies = @user.hobbies
    @hobby = @hobbies.build(hobbies_params)
    @hobby.title = "我的画廊" if (!params[:hobby][:title] || params[:hobby][:title].empty?)
    @hobby.content = nil if (!params[:hobby][:content] || params[:hobby][:content].empty?)
    if cookies[:created_hobby_id]
      t_hobby = Hobby.find_by(id: session[:created_hobby_id])
      t_hobby.update_attribute(:title, @hobby.title)
      t_hobby.update_attribute(:content, @hobby.content)
      t_hobby.reload
      @hobby = t_hobby
      flash.now[:success] = "保存画廊成功!"
    else
      if (@hobby.save)
        cookies[:created_hobby_id] = @hobby.id
        flash.now[:success] = "保存画廊成功!"
      else
        flash.now[:danger] = "保存画廊失败了!" + getObjectErrors(@hobby)
      end
    end
    respond_js
  end

  def upload
    p params
    @hobby = Hobby.find_by(id: cookies[:created_hobby_id])
    # retry_time = 13
    # @hobby.with_lock do
    #   begin
    if (params[:upload][:files] && !params[:upload][:files].empty?)
      params[:upload][:files].each do |file|
        @hobby_item = @hobby.hobby_items.build
        @hobby_item.title = file.original_filename
        @hobby_item.image = file
        @hobby_item.user_id = @hobby.user_id
        @hobby_item.save
        p @hobby_item
        p @hobby_item.errors.messages

        # flash.now[:success] = "上传成功了!"
        # p @hobby_item
        # else
        # flash[:danger] = "上传失败了!" + getObjectErrors(@hobby)
        # end
      end
    end
    # rescue
    #   retry_time -= 1
    #   if retry_time > 0
    #     retry
    #   end
    # end
    # end
  end

  def edit_upload
    @hobby = Hobby.find_by(id: params[:upload][:hobby_id])
    if (params[:upload][:files] && !params[:upload][:files].empty?)
      params[:upload][:files].each do |file|
        @hobby_item = @hobby.hobby_items.build
        @hobby_item.title = file.original_filename
        @hobby_item.image = file
        @hobby_item.user_id = @hobby.user_id
        @hobby_item.save
        # flash.now[:success] = "上传成功了!"
        # p @hobby_item
        # else
        # flash[:danger] = "上传失败了!" + getObjectErrors(@hobby)
        # end
      end
    end
  end

  def new
  end

  def show
    @hobby = @user.hobbies.find_by(id: params[:id])
  end


  def refresh
    p params[:hobby_id]
    @hobby = @user.hobbies.find_by(id: params[:hobby_id])
    respond_js
  end

  def destroy
    @hobby = Hobby.find_by(id: params[:id])
    @hobby.destroy
    flash[:success] = "成功删除一个画廊!"
    redirect_to hobbies_path
  end

  def destroy_image
    @destroy_image_id = params[:delete_image][:image_id]
    @hobby_item = HobbyItem.find_by(id: params[:delete_image][:image_id])
    @hobby = @hobby_item.hobby
    if (@hobby_item.destroy)
      @hobby_item = nil
    end
    if (params[:button] == "show_delete")
      redirect_to hobby_path @hobby
      return
    end
    respond_js
  end


  private

  def init_post
    @user = User.find_by(id: ADMIN_ID)
  end

  def hobbies_params
    params.require(:hobby).permit(:title, :content)
  end
end
