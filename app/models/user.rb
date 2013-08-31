class User < ActiveRecord::Base
  has_secure_password
  has_many :messages
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cell_number, presence: true
  validates :email, presence: true, uniqueness: true
  # geocoded_by :ip_address
  # after_validation :geocode
  # after_create :twilio_sign_up
  # html5 geolocation api - get this back in JS, post back to app
  after_create :email_sign_up

  def twilio_sign_up
    client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    client.account.sms.messages.create(
      from: TWILIO_CONFIG['from'],
      to: self.cell_number,
      body: "Thanks for signing up. To verify your account, please reply HELLO to this message.")
  end

  def email_sign_up
    Notifier.signup_email(self).deliver
  end

  #Wedeliver.wedeliver_email(self).deliver

  # before_save :default_password

  # def default_password
  #   unless self.password.present?
  #     self.password = self.first_name.downcase
  #     self.password_confirmation = self.first_name.downcase
  #   end
  # end
end
