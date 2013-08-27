class PointsController < ApplicationController
  def create
    @point = Point.new
    @point.user_id = current_user.id
    @point.save
  end
end
