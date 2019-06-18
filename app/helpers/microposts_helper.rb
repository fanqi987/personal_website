module MicropostsHelper

  def getSecretIPName name
    # p name
    if name =~ /(2(5[0-5]{1}|[0-4]\d{1})|[0-1]?\d{1,2})(\.(2(5[0-5]{1}|[0-4]\d{1})|[0-1]?\d{1,2})){3}/
      tname = name.split(".")
      tname[tname.length-1]="*"
      # p tname.join('.')
      tname.join('.')
    else
      name
    end
  end

  # def change_comment_page
  #   p params
  #   # p @microposts
  #   @page_comment = params[:page_comment].to_i
  #   @micropost_comments = @micropost.comments[0...PAGINATE_NUM]
  #   if (@page_comment > 0)
  #     @load_micropost_comment_complete = false
  #     @maxPage_comment = ((@micropost.comments.length - 1) / (PAGINATE_NUM * @page_comment)).floor + 1
  #     if (@page_comment >= @maxPage_comment)
  #       @load_micropost_comment_complete = true
  #       @micropost_comments = @micropost.comments[0...@micropost.comments.length]
  #     else
  #       @micropost_comments = @micropost.comments[0...PAGINATE_NUM * @page_comment]
  #     end
  #   end
  #   # p @page_comment
  #   # p @maxPage_comment
  #   # p @load_micropost_comment_complete
  #   # p @micropost_comments
  # end

end
