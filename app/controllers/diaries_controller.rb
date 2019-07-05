class DiariesController < ApplicationController

  before_action :init_post
  before_action :store_current_url, only: [:show, :index]


  def show
    # todo 404 page
    @diary = Diary.find_by(id: params[:id])
    if @diary.draft
      if logged_in? && current_user.admin?
        redirect_to edit_diary_path @diary
      else
        flash[:warning] = "管理员才能编辑日志哦~"
        redirect_to diaries_path
      end
      return
    end
    @diary.update_attribute(:read, @diary.read + 1)
    @diaries = @diary.user.diaries.where('"diaries"."draft" = ?', false)
    p @diaries
    getObjectIndex @diary, @diaries
    @diary_comments = @diary.comments
    @diary_comments = @diary_comments.reverse_order
    @diary_comments = @diary_comments.paginate(page: params[:page], per_page: COMMENT_PAGE_NUM)
  end

  def index

    p @diaries
    p @diaries.count
    p params
    @draft = false
    @draft = true if params[:button] == "draft"
    @diaries = @user.diaries.where('"diaries"."draft" == ? ', @draft)
    @diaries = @diaries.paginate(page: params[:page], per_page: COMMENT_PAGE_NUM)

    if params[:search]
      t_start_time = params[:search][:start_time]
      t_end_time = params[:search][:end_time]
      t_word = params[:search][:word]

      @diaries = get_search_result @diaries,
                                   t_start_time,
                                   t_end_time,
                                   t_word,
                                   "diaries",
                                   nil
    end

  end

  def edit
    return if redirect_not_admin session[:current_url],
                                 "管理员才能写日志哦~"
    @diary = Diary.find_by(id: params[:id])
  end

  def create
    p params
    @diary = @user.diaries.build(diaries_params)
    @diary.title = getCurrentCorrectTime Time.now if !params[:diary][:title] || params[:diary][:title].empty?
    @diary.modified_time = Time.now
    p "rails " + @diary.content

    if params[:button] == "article"
      @diary.draft = false
      if @diary.save
        flash[:success] = "日志发表成功"
        session.delete :tmp_diary_id
        redirect_to diaries_path
        return
      else
        respond_to do |format|
          format.html
          format.js
        end
        return
      end
    elsif params[:button] == "draft"
      @diary.draft = true
      @diary.id = session[:tmp_diary_id] if session[:tmp_diary_id]
      if @diary.valid? && t_diary = Diary.find_by(id: @diary.id)
        t_diary.update_attribute :title, @diary.title
        t_diary.update_attribute :content, @diary.content
        t_diary.update_attribute :modified_time, @diary.modified_time
        t_diary.reload
        @diary = t_diary
      elsif @diary.valid?
        @diary.save
        @diary.reload
        session[:tmp_diary_id] = @diary.id
      else
      end
      respond_to do |format|
        format.html
        format.js
      end
      return
    end
    # flash[:danger] = "日志保存/发表不成功 " + @diary.errors.messages.collect {|k, v| v[0]}.to_s
    # redirect_to new_diary_path
  end

  def create_comment
    p params
    @diary = Diary.find_by(id: params[:id])
    @diary_comment = @diary.comments.build(diaries_comments_params)
    set_comment_user_attr @diary_comment
    setAvatar @diary_comment.avatar
    if (@diary_comment && @diary_comment.save)
      respond_js
    else
      flash[:danger] = "评论失败" + getObjectErrors(@diary_comment)
      redirect_to diary_path @diary
    end

  end

  def new
    return if redirect_not_admin diaries_path,
                                 "管理员才能写日志哦~"
    @diary = Diary.new
    session.delete :tmp_diary_id
  end

  def update
    return if redirect_not_admin diaries_path,
                                 "管理员才能写日志哦~"
    p params
    @diary = @user.diaries.build(diaries_params)
    @diary.id = params[:id].to_i
    @diary.title = getCurrentCorrectTime Time.now if !params[:diary][:title] || params[:diary][:title].empty?
    @diary.modified_time = Time.now
    if params[:button] == "article"
      @diary.draft = false
    elsif params[:button] == "draft"
      @diary.draft = true
    end
    if @diary.valid?
      t_diary = Diary.find_by(id: @diary.id)
      t_diary.update_attribute :title, @diary.title
      t_diary.update_attribute :content, @diary.content
      t_diary.update_attribute :modified_time, @diary.modified_time
      t_diary.update_attribute :draft, @diary.draft
      t_diary.reload
      @diary = t_diary
      if !@diary.draft
        flash[:success] = "日志发表成功"
        redirect_to diaries_path
        return
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
    return
  end

  def destroy
    @diary = Diary.find_by(id: params[:diary_id])
    if @diary && @diary.destroy
      flash[:success] = "草稿已经删除!"
    end
    redirect_to diaries_path + "?button=draft#article_main_title"
  end


  def destroy_comment
    p params
    @diary = Diary.find_by(id: params[:id])
    @diary_comment = @diary.comments.find_by(id: params[:comment_id])
    @diary_comment.destroy
    # if @diary_comment && @diary_comment.destroy
    respond_js
  end

  def like
    p params
    @diary = Diary.find_by(id: params[:diary_id])
    like_common @diary
  end

  # def like_comment
  #   @diary_comment=
  # end

  private

  def init_post
    @search_section = {search_section_name: " 搜索日志"}
    @search_modal = {search_modal_id: "search_diary_modal", modal_title: "搜索日志"}
    @user = User.find_by(id: ADMIN_ID)
    @diaries = @user.diaries
    # @diary = Diary.new

  end

  def diaries_params
    params.require(:diary).permit(:title, :content)
  end

  def diaries_comments_params
    params.require(:comment).permit(:content, :user_name)
  end

end
