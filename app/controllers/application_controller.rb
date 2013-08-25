class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return User.find_by(:id => session[:user_id])
  end

  def create_qrcode(user)
    unless user.qrcode.present?
      # qr = RQRCode::QRCode.new(user_url(user))
      # png = qr.to_img.resize(1000, 1000)
      # service = S3::Service.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'],:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
      # bucket = service.buckets.find('ilostandfound')

      # file = bucket.objects.build("#{user.id}qrcode.png")
      # file.content = png
      # file.save
      # png.resize(400, 400).write(Pathname.new("/#{user.id}qrcode.png"))
      # user.qrcode =  "http://s3-us-west-2.amazonaws.com/ilostandfound/#{user.id}qrcode.png"
      # user.save

      url = Googl.shorten(user_url(user))
      user.qr_code_uid = url.short_url[-5..-1]
      user.qrcode = "http://chart.googleapis.com/chart?cht=qr&chs=150x150&choe=UTF-8&chld=H&chl=#{url.short_url}"
      user.save
    end
  end
  helper_method :current_user
  helper_method :create_qrcode
end
