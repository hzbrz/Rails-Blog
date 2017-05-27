class ArticlesController < ApplicationController

# before_action is used to make sure that a specified method is called in the methods that are specified in the only array
  before_action :set_article_instance_to_id, only: [:show]

  def create
    # article_params is used to whitelist the attributes so that mass assignment to a form cannot happen
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was sucessfully created!"

      # redirects to /articles/show and displays the created article
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def new
    # Without creating the Article model and articles table you cannot do Article.new
    # It throws the error: uninitialized constant Article
    @article = Article.new
  end

  def show
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article_instance_to_id
      @article = Article.find(params[:id])
    end
end
