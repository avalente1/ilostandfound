class PointsController < ApplicationController
  def create
    @point = Point.new
    @point.user_id = current_user.id
    @point.save
    # flash[:notice] = "Thank you!  The owner has been notified. Now you can also use iLost&Found."
    # redirect_to user_url(current_user)
  end
end
