class ArticlesController < ApplicationController
 before_action :set_article, only: [:edit, :update, :destroy]

  def show
    if Article.find_by(params[:id]) == true
        @article = Article.find(params[:id])
    else
        flash[:notice] = "Article is not available in data. "
        redirect_to signup_path
    end
  end

  def index
    # @articles = current_user.articles.paginate(page: params[:page], per_page: 5)
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
     @article.user = current_user
    if @article.save
      flash[:notice] = "Articles was created sucessfully."
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if  @article.update(article_params)
      flash[:notice] = "Article was updated sucessfully. "
      redirect_to @article
    else
      render 'edit'
    end

  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end


  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end


    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own article"
        redirect_to @article
      end
    end
end
