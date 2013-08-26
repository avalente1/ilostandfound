class User < ActiveRecord::Base
  has_secure_password
  has_many :messages
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :cell_number, presence: true
  # validates :email, presence: true, uniqueness: true
  # geocoded_by :ip_address
  # after_validation :geocode

  # before_save :default_password

  # def default_password
  #   unless self.password.present?
  #     self.password = self.first_name.downcase
  #     self.password_confirmation = self.first_name.downcase
  #   end
  # end
end
