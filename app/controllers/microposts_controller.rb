class MicropostsController < ApplicationController

  before_action :post_init
  # before_action :check_logged_in,only:[:create]

  PAGINATE_NUM = 5

  attr_accessor :page, :maxPage

  def create
    return if redirect_not_admin microposts_path,
                                 "管理员才能发微博哦~"
    if (logged_in? && current_user.admin?)
      @micropost = current_user.microposts.build(micropost_params)
      if (params[:micropost][:file_image])
        @micropost.picture = params[:micropost][:file_image]
      end
      if (params[:micropost][:file_video])
        @micropost.video = params[:micropost][:file_video]
      end
      if (@micropost.save)
        redirect_to action: :index
      else
        p @micropost.errors.messages
        redirect_to action: :index
      end
    end
  end

  def create_comment
    p params
    @micropost_record = Micropost.find_by(id: params[:id]).comments.new(micropost_comment_params)
    set_comment_user_attr @micropost_record
    setAvatar @micropost_record
    # p @micropost_record
    # p @micropost_record.valid?
    # p @micropost_record.errors.messages
    # p Micropost.find_by(id:params[:id])
    if (@micropost_record.save)
      @micropost = Micropost.find_by(id: params[:id])
      change_comment_page
      respond_js
    else
      redirect_to microposts_path
    end
  end

  def destroy
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @micropost.destroy
    flash[:success] = "微博已成功删除!"
    redirect_to microposts_path + "#micropost_main"
  end

  def destroy_comment

    @micropost_record = Comment.find_by(id: params[:micropost_comment_id])
    # p @micropost_record
    @micropost = @micropost_record.commentable
    # p @micropost
    @micropost_record.destroy

    change_comment_page

    respond_js
  end

  def index
    # todo javascript 微博的展开和关闭效果
    #记录当前微博页是索引还是子项目页

    p params
    session[:microposts_page] = request.original_url
    if params[:search]
      t_start_time = params[:search][:start_time]
      t_end_time = params[:search][:end_time]
      t_word = params[:search][:word]
    end
    @microposts = change_micropost_page @user.microposts,
                                        t_start_time,
                                        t_end_time,
                                        t_word,
                                        1

  end

  def show
    #记录当前微博页是索引还是子项目页
    session[:microposts_page] = request.original_url
    @micropost = Micropost.find_by(id: params[:id])
    @page_comment = 1
    @load_micropost_comment_complete = false
    @maxPage_comment = ((@micropost.comments.length - 1) / (PAGINATE_NUM * @page_comment)).floor + 1
    if (@page_comment >= @maxPage_comment)
      @load_micropost_comment_complete = true
      @micropost_comments = @micropost.comments[0...@micropost.comments.length]
    else
      @micropost_comments = @micropost.comments[0...PAGINATE_NUM]
    end
  end

  def like
    @micropost = Micropost.find_by(id: params[:micropost_id])
    like_common @micropost
  end

  def comment_like
    @micropost_record = Comment.find_by(id: params[:micropost_comment_id])
    like_common @micropost_record
  end

  def more
    @microposts = @user.microposts
    @microposts = change_micropost_page @microposts,
                                        params[:start_time],
                                        params[:end_time],
                                        params[:word],
                                        params[:page].to_i
    respond_js
  end

  def more_comment

    @load_micropost_comment_complete = false
    @page_comment = params[:page_comment].to_i
    @maxPage_comment = params[:maxPage_comment].to_i
    p params
    @micropost = Micropost.find_by(id: params[:id])
    @page_comment += 1
    if (@page_comment >= @maxPage_comment)
      @load_micropost_comment_complete = true
      @micropost_comments = @micropost.comments
    else
      @micropost_comments = @micropost.comments[0...PAGINATE_NUM * @page_comment]
    end
    respond_js
  end

  private

  def post_init
    @post = {post_modal_id: 'post_micropost_modal', micropost: true, modal_title: '发布新微博'}
    @search_section = {search_section_name: " 搜索微博"}
    @search_modal = {search_modal_id: "search_micropost_modal", modal_title: '搜索微博'}
    @user = User.find_by(id: ADMIN_ID)
    @microposts = @user.microposts if @user
    @micropost = Micropost.new
    @micropost_record = Comment.new
    @like = Like.new
    # p @microposts
  end

  def micropost_params
    params.require(:micropost).permit(:content, :picture, :video)
  end

  def micropost_comment_params
    params.require(:comment).permit(:content, :user_name)
  end

  def change_comment_page
    p params
    # p @microposts
    @page_comment = params[:page_comment].to_i
    @micropost_comments = @micropost.comments[0...PAGINATE_NUM]
    if (@page_comment > 0)
      @load_micropost_comment_complete = false
      @maxPage_comment = ((@micropost.comments.length - 1) / (PAGINATE_NUM * @page_comment)).floor + 1
      if (@page_comment >= @maxPage_comment)
        @load_micropost_comment_complete = true
        @micropost_comments = @micropost.comments[0...@micropost.comments.length]
      else
        @micropost_comments = @micropost.comments[0...PAGINATE_NUM * @page_comment]
      end
    end

  end

  def change_micropost_page(objects, start_time, end_time, search_word, page)

    objects = get_search_result objects,
                                start_time,
                                end_time,
                                search_word,
                                "microposts",
                                nil

    @microposts_length = objects.length
    p objects
    p objects.length
    #初始化分页,显示列表
    @page = page
    @load_micropost_complete = false
    @maxPage = ((objects.length - 1) / (PAGINATE_NUM)).floor + 1
    if (@page >= @maxPage)
      @load_micropost_complete = true
    else
      objects = objects[0...PAGINATE_NUM * @page]
    end
    return objects
  end


end
