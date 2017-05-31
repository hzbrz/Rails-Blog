class UsersController < ApplicationController

  before_action :set_user_instance_to_id, only: [:edit, :show, :update]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome to the Rails Blog #{@user.username}"
      redirect_to user_path(user)
    else
      render 'new'
    end
  end

  def edit
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was successfully updated!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

    def set_user_instance_to_id
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if logged_in? && current_user != @user
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end
end