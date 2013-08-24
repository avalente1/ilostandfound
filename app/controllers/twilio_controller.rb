class User < ActiveRecord::Base
  attr_accessor :email, :name, :phone

  validates :name, presence: true
  validates :email, :cell_phone, presence: true, uniqueness: true
end
