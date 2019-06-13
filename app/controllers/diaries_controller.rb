class DiariesController < ApplicationController

  before_action :init_post

  def show

  end

  def index
    p @diaries
    p @diaries.count
    p params
    @draft = false
    @draft = true if params[:button] == "draft"
    @diaries = @user.diaries.where("'diaries'.'draft' == ? ", @draft)
    @diaries = @diaries.paginate(page: params[:page], per_page: 10)
  end

  def edit
    return if redirect_not_admin diaries_path,
                                 "管理员才能写日志哦~"
    @diary = Diary.find_by(id: params[:id])
  end

  def create
    p params
    @diary = @user.diaries.build(diaries_params)
    @diary.title = Time.now.localtime.strftime("%Y-%m-%d %H:%M:%S") if !params[:diary][:title] || params[:diary][:title].empty?
    @diary.modified_time = Time.now
    p "rails " + @diary.content
    # session[:tmp_diary_content] = @diary.content
    # session[:tmp_diary_title] = @diary.title

    if params[:button] == "article"
      @diary.draft = false
      if @diary.save
        flash[:success] = "日志发表成功"
        # session.delete :tmp_diary_title
        # session.delete :tmp_diary_content
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

  def new
    return if redirect_not_admin diaries_path,
                                 "管理员才能写日志哦~"
    @diary = Diary.new
    # @diary.content = session[:tmp_diary_content]
    # @diary.title = session[:tmp_diary_title]
    # @diary.id = session[:tmp_diary_id]
    session.delete :tmp_diary_id
  end

  def update
    return if redirect_not_admin diaries_path,
                                 "管理员才能写日志哦~"
    p params
    @diary = @user.diaries.build(diaries_params)
    @diary.id = params[:id].to_i
    @diary.title = Time.now.localtime.strftime("%Y-%m-%d %H:%M:%S") if !params[:diary][:title] || params[:diary][:title].empty?
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
        # session.delete :tmp_diary_title
        # session.delete :tmp_diary_content
        # session.delete :tmp_diary_id
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

end
