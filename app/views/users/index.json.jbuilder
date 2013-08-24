json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name, :cell_show, :cell_number, :email_show, :home_phone_show, :home_phone, :password_digest, :address1, :address2, :city, :state, :postal, :qrcode
  json.url user_url(user, format: :json)
end
