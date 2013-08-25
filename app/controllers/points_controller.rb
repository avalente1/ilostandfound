class PointsController < ApplicationController

  def new
  end

  def create
    @point = Point.new
    @point.user_id = current_user.id
    @point.save
    flash[:notice] = "Thank you!  The owner has been notified. Now you can also use iLost&Found."
    redirect_to user_url(current_user)
  end

  def show
  end

  def update
  end

  def destroy
    @point.destroy
    redirect_to votes_url, :notice => "Vote Destroyed"
  end

end
