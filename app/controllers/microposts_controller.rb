class MicropostsController < ApplicationController

  before_action :post_init
  # before_action :check_logged_in,only:[:create]

  PAGINATE_NUM = 3

  attr_accessor :page, :maxPage

  def create

    if (logged_in? && current_user.admin?)
      @micropost = current_user.microposts.build(micropost_params)
      if (@micropost.save)
        redirect_to action: :index
      else
        render 'microposts/index'
      end
      return
    end

    if logged_in? && !current_user.admin?
      flash.now[:danger] = "普通用户暂不能发表微博"
    else
      flash.now[:danger] = "登录后再发表微博哦~"
    end

    respond_js
    return

  end

  def create_comment
    p params
    @micropost_record = MicropostRecord.new(micropost_comment_params)
    @micropost_record.micropost_id = params[:id]
    if (logged_in?)
      @micropost_record.user_id = current_user.id
      @micropost_record.user_name = current_user.name
    elsif !params[:micropost_record][:user_name].empty?
      @micropost_record.user_name = params[:micropost_record][:user_name]
      session[:user_name] = params[:micropost_record][:user_name]
    else
      @micropost_record.user_name = request.remote_ip
    end


    if (@micropost_record.save)
      @micropost = Micropost.find_by(id: params[:id])

      change_comment_page

      respond_js
    else
      render 'microposts/index'
    end

  end

  def destroy
    @micropost = Micropost.find_by(id: params[:micropost_id])
    # p Micropost.count
    @micropost.destroy
    # p Micropost.count
    flash[:success] = "微博已成功删除!"
    redirect_to microposts_path + "#micropost_main"
  end

  def destroy_comment

    # @micropost_records = MicropostRecord.new(params[:micropost_records])
    @micropost_record = MicropostRecord.find_by(id: params[:micropost_comment_id])
    @micropost = @micropost_record.micropost
    @micropost_record.destroy

    change_comment_page

    respond_js
  end

  def index
    #初始化分页,显示最初的列表
    session[:microposts_page] = request.original_url
    @page = 1
    @load_micropost_complete = false
    @maxPage = ((@user.microposts.length - 1) / (PAGINATE_NUM * @page)).floor + 1
    if (@page >= @maxPage)
      @load_micropost_complete = true
      @microposts = @user.microposts[0...@user.microposts.length]
    else
      @microposts = @user.microposts[0...PAGINATE_NUM]
    end
  end

  def show
    session[:microposts_page] = request.original_url
    @micropost = Micropost.find_by(id: params[:id])
    @page_comment = 1
    @load_micropost_comment_complete = false
    @maxPage_comment = ((@micropost.micropost_records.length - 1) / (PAGINATE_NUM * @page_comment)).floor + 1


    if (@page_comment >= @maxPage_comment)
      @load_micropost_comment_complete = true
      @micropost_records = @micropost.micropost_records[0...@micropost.micropost_records.length]
    else
      @micropost_records = @micropost.micropost_records[0...PAGINATE_NUM]
    end

  end

  def like
    @micropost = Micropost.find_by(id: params[:micropost_id])
    like_common @micropost
  end

  def comment_like
    @micropost_record = MicropostRecord.find_by(id: params[:micropost_comment_id])
    like_common @micropost_record
  end

  def more
    # @page += 1
    @load_micropost_complete = false
    @page = params[:page].to_i
    @maxPage = params[:maxPage].to_i
    if (@page >= @maxPage)
      @load_micropost_complete = true
      @microposts = @user.microposts
    else
      @microposts = @microposts[0...PAGINATE_NUM * @page]
    end

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
      @micropost_records = @micropost.micropost_records
    else
      @micropost_records = @micropost.micropost_records[0...PAGINATE_NUM * @page_comment]
    end
    respond_js
  end

  private

  def post_init
    @post = {post_modal_id: 'post_micropost_modal', img_choose: true, modal_title: '发布新微博'}
    @user = User.find_by(id: ADMIN_ID)
    @microposts = @user.microposts if @user
    @micropost = Micropost.new
    @micropost_record = MicropostRecord.new
    @like = Like.new
    # p @microposts
  end

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def micropost_comment_params
    params.require(:micropost_record).permit(:content, :user_name)
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

  def change_comment_page
    @page_comment = params[:page_comment].to_i
    @micropost_records = @micropost.micropost_records[0...PAGINATE_NUM]
    if (@page_comment > 0)
      @load_micropost_comment_complete = false
      @maxPage_comment = ((@micropost.micropost_records.length - 1) / (PAGINATE_NUM * @page_comment)).floor + 1
      if (@page_comment >= @maxPage_comment)
        @load_micropost_comment_complete = true
        @micropost_records = @micropost.micropost_records[0...@micropost.micropost_records.length]
      else
        @micropost_records = @micropost.micropost_records[0...PAGINATE_NUM * @page_comment]
      end
    end
    p @page_comment
    p @maxPage_comment
    p @load_micropost_comment_complete
    p @micropost_records
  end

  def respond_js
    respond_to do |format|
      format.html {redirect_to microposts_path}
      format.js
    end
  end
end
