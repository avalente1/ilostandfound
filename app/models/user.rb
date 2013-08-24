class User < ActiveRecord::Base
  has_secure_password
  has_many :messages

  after_save :create_qrcode
  # before_save :default_password

  def create_qrcode
    unless self.qrcode.present?
      qr = RQRCode::QRCode.new("http://localhost:3000/users/#{self.id}", size: 4, level: :h)
      png = qr.to_img
      png.resize(400, 400).save("app/assets/images/qrcodes/#{self.id}qrcode.png")
      self.qrcode =  "/assets/qrcodes/#{self.id}qrcode.png"
      self.save
    end
  end

  # def default_password
  #   unless self.password.present?
  #     self.password = self.first_name.downcase
  #     self.password_confirmation = self.first_name.downcase
  #   end
  # end

end
