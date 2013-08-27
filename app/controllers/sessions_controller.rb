class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(:email => params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back, #{current_user.first_name}"
      redirect_to user_url(@user.id)
    else
      flash[:error] = "Email and password combination do not match. Please try again!"
      redirect_to home_url
    end
  end

  def destroy
    reset_session
    flash[:notice] = "User Logged Out"
    redirect_to root_url
  end
end
