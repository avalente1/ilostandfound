class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return User.find_by(:id => session[:user_id])
  end

  def create_qrcode(user)
    unless user.qrcode.present?
      qr = RQRCode::QRCode.new(user_url(user), size: 8, level: :h)
      png = qr.to_img
      png.resize(400, 400).save("app/assets/images/qrcodes/#{user.id}qrcode.png")
      user.qrcode =  "/assets/qrcodes/#{user.id}qrcode.png"
      user.save
    end
  end
  helper_method :current_user
  helper_method :create_qrcode
end
