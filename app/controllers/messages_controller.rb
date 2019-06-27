class MessagesController < ApplicationController

  before_action :init_post

  MESSAGES_PAGE_NUM = 10

  def index
    if (!@message = @user.message)
      @user.message = Message.new
      @message = @user.message
      @message.save
    end
    @comment = @user.message.comments.build
    @comments = @user.message.comments.paginate(page: params[:page], per_page: MESSAGES_PAGE_NUM)
  end

  def create
    @comment = @user.message.comments.build(messages_params)
    set_comment_user_attr @comment
    if @comment.save
      respond_js
    else
      flash[:now] = "发表失败了,请重试" + getObjectErrors(@comment)
      respond_js
    end
  end

  def destroy
    @message = @user.message
    @comment = @message.comments.find_by(id: params[:comment_id])
    @comment.destroy
    # if @diary_comment && @diary_comment.destroy
    respond_js
  end

  private

  def init_post
    @user = User.find_by(id: ADMIN_ID)
  end

  def messages_params
    params.require(:comment).permit(:user_name, :content, :email)
  end

end
