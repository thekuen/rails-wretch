class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article, only: [:create]

  def create
  #這裡在寫些什麼東西?
  #@comment = Comments.new(comment_params)
  #@comment.user = current_user
  #@comment.article = @article

  #需要user需要article
  #以article角度新增留言
    @comment = @article.comments.new(comment_params)

    if @comment.save
   #redirect_to article_path(@article), notice:'留言成功'
    else 
   #comment的create頁面，使用articles的show
     render "articles/show"
    end
  end

  private
  def find_article
   @article =  Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment)
          .permit(:content)
          .merge(user: current_user)
  end
end



