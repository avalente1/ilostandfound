class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(:email => params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "User Successfully Logged In"
    else
      flash[:error] = "Something Went Wrong, Please Try Again"
      render 'new'
    end
  end

  def destroy
    reset_session
    flas[:notice] = "User Logged Out"
    redirect_to
  end
end
