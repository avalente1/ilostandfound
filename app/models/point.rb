class Point < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  after_create :update_point_tally

  def update_point_tally
    self.user.point_tally += 1
    self.user.save
  end
end
