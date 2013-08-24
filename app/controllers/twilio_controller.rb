class User < ActiveRecord::Base
  attr_accessor :email, :name, :cell_number

  validates :name, presence: true
  validates :email, :cell_number, presence: true, uniqueness: true
end
