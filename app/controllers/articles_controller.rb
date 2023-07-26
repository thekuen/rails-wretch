class ArticlesController < ApplicationController
    before_action :set_article, only:[:show]
    before_action :set_user_article, only:[:edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
 
    def set_article
        @article = Article.find(params[:id])
    end

    def set_user_article
        @article = current_user.articles.find(params[:id])
    end


    def index       
        #@articles = Article.all.order(id: :desc)
        @articles = Article.includes(:user).order(id: :desc)    
    end

  

    def new
        #實體變數
        @article = Article.new
    end 

    def article_params
        params.require(:article)
              .permit(:title, :sub_title, :content)
              #.merge(:user)????

    end

    def create
        #@article = Article.new(article_params)
        @article = current_user.articles.new(article_params)
        #會帶入current_user的資料在articles裡面     

        #寫入資料庫
        #Strong paramenter
        #clean_params= params.require(:cc).permit(:title, :coutent)
        if @article.save
            redirect_to "/articles"
            flash[:notice] = "文章新增成功"
        else
           render :new
        end
        #article = Article.new(title: params:[:cc][:title],
                          #content: params[:cc] [:content])
        #article.save  
        
        #cc = Article.new
        #cc.title = params[:cc][:title]
        #cc.content = params[:cc][:content]
        #cc.save
    end

  
    def show
        @comment = Comment.new
        @comments = @article.comments.order(id: :desc)
      
       
    end



    def edit
        @article = Article.find(params[:id])        
    end

    def update
        @article = Article.find(params[:id])  
        if @article.update(article_params)
            redirect_to articles_path, notice: '更新成功'    
           
        else
            render :edit            
        end
        
    end

    def destroy
       
        #@article = Article.find(params[:id])  
        @article.destroy
        redirect_to articles_path, notice: '刪除成功' 
    end    



end
