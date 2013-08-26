class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return User.find_by(:id => session[:user_id])
  end

  def create_qrcode(user)
    unless user.qrcode.present?
      url = Googl.shorten(user_url(user))
      user.qr_code_uid = url.short_url.split('/').last
      user.qrcode = "http://chart.googleapis.com/chart?cht=qr&chs=150x150&choe=UTF-8&chld=H&chl=#{url.short_url}"
    end
  end
  helper_method :current_user
  helper_method :create_qrcode
end
