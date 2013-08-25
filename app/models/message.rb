class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :finder, class_name: 'User'

  after_create :add_point

  def add_point
    @point = Point.new
    @point.user_id = self.find_id
    @point.save
  end
end
