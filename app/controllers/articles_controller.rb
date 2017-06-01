class ArticlesController < ApplicationController

# before_action is used to make sure that a specified method is called in the methods that are specified in the only array
  before_action :set_article_instance_to_id, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # Creates a new article instance with GET request
  def new
    # Without creating the Article model and articles table you cannot do Article.new
    # It throws the error: uninitialized constant Article
    @article = Article.new
  end

  # Here the form submission is handled and the POST request goes through
  # new action is the GET request and create action is the POST request
  def create
    # article_params is used to whitelist the attributes so that mass assignment to a form cannot happen
    @article = Article.new(article_params)

    # This sets the article created by the user as the current user
    @article.user = current_user

    if @article.save
      flash[:success] = "Article was sucessfully created!"

      # redirects to /articles/show and displays the created article
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    # update is used instead of saved since the article has already been created
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"

      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article_instance_to_id
      @article = Article.find(params[:id])
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path
      end
    end
end
