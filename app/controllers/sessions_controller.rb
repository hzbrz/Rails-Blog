class SessionsController < ApplicationController

  # gets the login form
  def new
  end

  # handles the submission form
  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    # sets the user_id to nil thus resetting the login behavior
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
