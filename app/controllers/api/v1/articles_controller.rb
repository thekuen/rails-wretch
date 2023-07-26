class Api::V1::ArticlesController < ApplicationController
#在application_controller的方法名字，這一頁就要寫什麼
 before_action :authenticate_user!

    def like   
      article = Article.find(params[:id])
      # p article
      # p current_user
      # p current_user.liked_articles
      # p "%"*100


      status = current_user.toggle_like(article)
      render json: {liked: status}

      
      #如果喜歡該文章
      #  if current_user.liked_articles.include?(article)
      #  if current_user.liked?(article)
      
        # current_user.liked_articles.destroy(article)
        #驚嘆號代表想做某件事情,是一個行為
        #改成不喜歡
        # current_user.unlike!(article)
        # render json: {liked: false,  id: params[:id]} 
 
 
      #  else
         #改成喜歡push這篇文章 
        #  current_user.liked_articles << article
        #  current_user.like!(article)
        #  render json: {liked: true,  id: params[:id]}
 
 
      #  end
 




    end
  
  
  
  
  end