class Message < ActiveRecord::Base
  validates :subject, presence: true
  validates :text, presence: true
  validates :find_id, presence: true
  validates :owner_id, presence: true

  belongs_to :owner, class_name: 'User'
  belongs_to :find, class_name: 'User'

  reverse_geocoded_by :latitude, :longitude, :address => :ip_address
  after_validation :reverse_geocode

  after_create :add_point
  # after_create :twilio_lost_item_notification
  # after_create :email_lead_to_wedeliver

  def add_point
    @point = Point.new
    @point.user_id = self.find_id
    @point.save
  end

  def self.twilio_lost_item_notification(id)
    find(id).twilio_lost_item_notification
  end

  def twilio_lost_item_notification
    client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    client.account.sms.messages.create(
      from: TWILIO_CONFIG['from'],
      to: User.find_by(id: self.owner_id).cell_number,
      body: "Someone has found your #{self.subject}")
  end

  def self.email_lost_item_notification(id)
    find(id).email_lost_item_notification
  end

  def email_lost_item_notification
    Notifier.found_item_to_owner_email(self).deliver
  end

  # def email_lead_to_wedeliver
  #   Wedeliver.wedeliver_email(@user).deliver
  # end
end
