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
      flash[:error] = "Something Went Wrong, Please Try Again"
      render 'new'
    end
  end

  def destroy
    reset_session
    flash[:notice] = "User Logged Out"
    redirect_to new_session_url
  end
end
